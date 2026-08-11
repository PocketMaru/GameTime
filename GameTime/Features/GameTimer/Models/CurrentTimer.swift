import Foundation


/// Represents a single, independently running timer session.
///
/// Each `CurrentTimer` owns a unique and stable `id` that identifies the
/// individual running session. Multiple `CurrentTimer` instances may be created
/// from the same `GameTimer`, so `id` must not be derived from `model.id`.
///
/// The `GameTimer.id` identifies the reusable timer model, while
/// `CurrentTimer.id` identifies one specific use of that model. Deriving the
/// session's identity from `model.id` would give every session created from the
/// same model an identical ID, preventing SwiftUI collections such as `ForEach`
/// from reliably distinguishing their views and observable `timer` state.
///
/// Keeping `id` as a stored value ensures it remains unique between sessions
/// and stable throughout the lifetime of each `CurrentTimer`.

@MainActor
struct CurrentTimer: Identifiable, Hashable {
    var id: UUID = UUID()
    var model: GameTimer
    let timer: TimerVM
}
