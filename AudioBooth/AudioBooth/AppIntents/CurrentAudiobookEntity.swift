import AppIntents
import Foundation
import Models

/// The audiobook the user is listening to right now.
///
/// Its query suggests only that one book, so the parameterized "Jump into book" App Shortcut
/// shows up in Shortcuts and Spotlight under the current book's title.
struct CurrentAudiobookEntity: AppEntity, Identifiable {
  let id: String
  let title: String
  let author: String?

  static var typeDisplayRepresentation: TypeDisplayRepresentation = "Current Audiobook"
  static var defaultQuery = CurrentAudiobookQuery()

  var displayRepresentation: DisplayRepresentation {
    DisplayRepresentation(
      title: "\(title)",
      subtitle: author.map { "\($0)" }
    )
  }

  init(id: String, title: String, author: String?) {
    self.id = id
    self.title = title
    self.author = author
  }

  /// Builds the entity from the live player when it is playing this book, otherwise from the
  /// stored book. Returns nil for podcast episodes and books with no audio.
  init?(bookID: String) {
    if let player = PlayerManager.shared.current, player.id == bookID {
      guard player.podcastID == nil else { return nil }
      self.init(id: bookID, title: player.title, author: player.author)
      return
    }

    guard let book = try? LocalBook.fetch(bookID: bookID), book.mediaType.contains(.audiobook) else {
      return nil
    }
    self.init(
      id: bookID,
      title: book.title,
      author: book.authorNames.isEmpty ? nil : book.authorNames
    )
  }
}

struct CurrentAudiobookQuery: EntityQuery {
  func entities(for identifiers: [String]) async throws -> [CurrentAudiobookEntity] {
    await Self.entities(for: identifiers)
  }

  func suggestedEntities() async throws -> [CurrentAudiobookEntity] {
    await Self.currentEntity().map { [$0] } ?? []
  }

  /// A shortcut saved earlier may name a book that's no longer current; it still resolves so
  /// running it jumps into the book its tile showed.
  @MainActor
  private static func entities(for identifiers: [String]) -> [CurrentAudiobookEntity] {
    identifiers.map { id in
      CurrentAudiobookEntity(bookID: id) ?? CurrentAudiobookEntity(id: id, title: "Audiobook", author: nil)
    }
  }

  @MainActor
  private static func currentEntity() -> CurrentAudiobookEntity? {
    PlayerManager.shared.currentBookID.flatMap(CurrentAudiobookEntity.init(bookID:))
  }
}
