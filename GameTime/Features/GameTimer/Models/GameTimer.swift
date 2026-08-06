import Foundation

struct GameTimer: Identifiable, Hashable {
    let id: UUID
    var name: String
    var timer: Int
}

extension GameTimer {
    init(_ record: GameTimerRecord) {
        self.id = record.id
        self.name = record.name
        self.timer = record.timer
    }
}
