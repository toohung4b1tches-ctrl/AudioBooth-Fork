import AppIntents
import Foundation

/// Opens the app straight into the most recently played audiobook and starts playing.
///
/// When the book has an ebook, the reader opens and Read Along starts following the narrator.
/// Otherwise the full player opens.
struct JumpIntoBookIntent: AppIntent {
  static let title: LocalizedStringResource = "Jump into book"
  static let description = IntentDescription(
    "Opens your most recent audiobook and starts playing. If it has an ebook, the reader opens with Read Along following the narrator."
  )
  static let openAppWhenRun = true

  init() {}

  func perform() async throws -> some IntentResult {
    let bookID = await MainActor.run { PlayerManager.shared.currentBookID }
    guard let bookID else {
      throw AppIntentError.custom("You haven't listened to an audiobook yet.")
    }
    try await PlayerManager.shared.jumpIn(bookID: bookID)
    return .result()
  }
}
