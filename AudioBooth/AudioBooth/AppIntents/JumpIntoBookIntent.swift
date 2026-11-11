import AppIntents
import Foundation

/// Opens the app straight into the current book and starts playing.
///
/// When the book has an ebook, the reader opens and Read Along starts following the narrator.
/// Otherwise the full player opens.
struct JumpIntoBookIntent: AppIntent {
  static let title: LocalizedStringResource = "Jump into book"
  static let description = IntentDescription(
    "Opens your current audiobook and starts playing. If it has an ebook, the reader opens with Read Along following the narrator."
  )
  static let openAppWhenRun = true

  static var parameterSummary: some ParameterSummary {
    Summary("Jump into \(\.$book)")
  }

  @Parameter(title: "Book")
  var book: CurrentAudiobookEntity

  init() {}

  init(book: CurrentAudiobookEntity) {
    self.book = book
  }

  func perform() async throws -> some IntentResult {
    try await PlayerManager.shared.jumpIn(bookID: book.id)
    return .result()
  }
}
