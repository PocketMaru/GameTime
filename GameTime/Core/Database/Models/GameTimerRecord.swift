import Foundation
import SQLiteData

@Table
struct GameTimerRecord: Identifiable {
    let id: UUID
    var name: String
    var timer: Int
}

extension GameTimerRecord {
    init(_ model: GameTimer) {
        self.id = model.id
        self.name = model.name
        self.timer = model.timer
    }
}
