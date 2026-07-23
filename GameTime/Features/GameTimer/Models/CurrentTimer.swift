import Foundation

@MainActor
struct CurrentTimer: Identifiable, Hashable {
    let id = UUID()
    var model: GameTimer
    let timer: TimerVM
}
