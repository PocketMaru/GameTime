import Foundation

@MainActor
struct CurrentTimer: Identifiable, Hashable {
    var id: GameTimer.ID { model.id }
    var model: GameTimer
    let timer: TimerVM
}
