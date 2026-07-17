import Foundation

extension GameTimer {
    struct Draft: Equatable {
        var id: UUID?
        var name: String?
        var timer: Int?
        
        var formState: FormState {
            id == nil ? .create : .update
        }
        
        init() {}
        
        init(_ gameTimer: GameTimer) {
            self.id = gameTimer.id
            self.name = gameTimer.name
            self.timer = gameTimer.timer
        }
    }
}

extension GameTimer.Draft {
    enum FormState {
        case create
        case update
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
        // I went with this rendition to keep create from validating something already implied by formState. 
        let id: GameTimer.ID = try {
           switch formState {
           case .create:
               return .init()
           case .update:
               guard let id = id else {
                   throw GameTimerError.missingID
               }
               return id
            }
        }()
        
        return GameTimer(
            id: id,
            name: name,
            timer: timer
        )
    }
}
