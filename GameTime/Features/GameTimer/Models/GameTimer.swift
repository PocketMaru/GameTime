import Foundation

struct GameTimer: Identifiable, Hashable {
    let id: UUID
    var name: String
    var timer: Int
}

extension GameTimer {
    func toDraft() -> GameTimer.Draft {
        Draft(self)
    }
}
