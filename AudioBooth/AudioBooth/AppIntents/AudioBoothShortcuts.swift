import AppIntents
import PlayerIntents

@available(iOS 18.0, *)
struct AudioBoothShortcuts: AppShortcutsProvider {
  // iOS allows at most 10 App Shortcuts. SkipToPreviousChapterIntent was dropped to make room
  // for JumpIntoBookIntent; it remains available as an action in the Shortcuts app.
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: JumpIntoBookIntent(),
      phrases: [
        "Jump into my book with \(.applicationName)",
        "Jump into my book in \(.applicationName)",
        "Jump into \(.applicationName)",
        "Read along in \(.applicationName)",
      ],
      shortTitle: "Jump into book",
      systemImageName: "book.fill"
    )

    AppShortcut(
      intent: PlayAudiobookIntent(),
      phrases: [
        "Play \(\.$target) with \(.applicationName)",
        "Play \(\.$target) in \(.applicationName)",
        "Play \(\.$target) on \(.applicationName)",
      ],
      shortTitle: "Play audiobook",
      systemImageName: "play.fill"
    )

    AppShortcut(
      intent: PausePlaybackIntent(),
      phrases: [
        "Pause playback in \(.applicationName)",
        "Pause \(.applicationName)",
      ],
      shortTitle: "Pause playback",
      systemImageName: "pause.fill"
    )

    AppShortcut(
      intent: ResumePlaybackIntent(),
      phrases: [
        "Resume playback in \(.applicationName)",
        "Resume \(.applicationName)",
        "Play \(.applicationName)",
        "Play my audiobook with \(.applicationName)",
        "Play my audiobook in \(.applicationName)",
        "Play my book with \(.applicationName)",
        "Play my book in \(.applicationName)",
        "Continue my audiobook with \(.applicationName)",
        "Continue my book with \(.applicationName)",
      ],
      shortTitle: "Resume playback",
      systemImageName: "play.fill"
    )

    AppShortcut(
      intent: SkipBackwardIntent(),
      phrases: [
        "Skip backward in \(.applicationName)",
        "Go back in \(.applicationName)",
      ],
      shortTitle: "Skip backward",
      systemImageName: "gobackward.30"
    )

    AppShortcut(
      intent: SkipForwardIntent(),
      phrases: [
        "Skip forward in \(.applicationName)",
        "Go forward in \(.applicationName)",
      ],
      shortTitle: "Skip forward",
      systemImageName: "goforward.30"
    )

    AppShortcut(
      intent: SkipToNextChapterIntent(),
      phrases: [
        "Skip to next chapter in \(.applicationName)",
        "Next chapter in \(.applicationName)",
      ],
      shortTitle: "Next chapter",
      systemImageName: "forward.end.fill"
    )

    AppShortcut(
      intent: SetSleepTimerWithDurationIntent(),
      phrases: [
        "Set sleep timer in \(.applicationName)",
        "Set timer in \(.applicationName)",
      ],
      shortTitle: "Set sleep timer",
      systemImageName: "timer"
    )

    AppShortcut(
      intent: CancelSleepTimerIntent(),
      phrases: [
        "Cancel sleep timer in \(.applicationName)",
        "Turn off timer in \(.applicationName)",
      ],
      shortTitle: "Cancel sleep timer",
      systemImageName: "timer"
    )

    AppShortcut(
      intent: AddBookmarkIntent(),
      phrases: [
        "Add a bookmark in \(.applicationName)",
        "Bookmark in \(.applicationName)",
        "Create bookmark in \(.applicationName)",
      ],
      shortTitle: "Add bookmark",
      systemImageName: "bookmark"
    )
  }
}
