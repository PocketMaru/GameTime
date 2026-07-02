import Foundation

extension GameTimer {
    struct Draft: Equatable {
        let id: UUID
        var name: String?
        var timer: Double?
    }
}

extension GameTimer.Draft {
    func toModel() throws -> GameTimer {
        guard let name else {
            throw GameTimerError.missingName
        }
        guard let timer else {
            throw GameTimerError.missingTimer
        }
        return GameTimer(
            id: id,
            name: name,
            timer: timer
        )
    }
}
