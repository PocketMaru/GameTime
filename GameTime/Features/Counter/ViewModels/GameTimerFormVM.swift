import Foundation
import Observation

enum GameTimerError: Error {
    case gameTimerNotFound
    case missingTimer
    case missingName
    case FailedModelConversion
}

enum FormMode {
    case create
    case edit
}

@MainActor
@Observable
final class GameTimerFormVM {
    var draft: GameTimer.Draft
    var name: String? = ""
    var timer: String? = ""
    var mode: FormMode
    var onSubmit: ((GameTimer.Draft) -> Void)?
    
    init(
        draft: GameTimer.Draft,
        mode: FormMode,
        onSubmit: ((GameTimer.Draft) -> Void)?
    ) {
        if mode == .edit {
            name = draft.name
            timer = draft.timer.map { String($0) } ?? ""
        }
        self.draft = draft
        self.mode = mode
        self.onSubmit = onSubmit
    }
    
    func submit() {
        draft.name = name
        draft.timer = Double(timer ?? "0")
        guard validate() else { return }
        onSubmit?(draft)
    }
    
    func validate() -> Bool {
        var errors: [GameTimerError] = []
        if draft.name?.isEmpty ?? true {
            errors.append(.missingName)
        }
        if draft.timer == nil || draft.timer == 0 {
            errors.append(.missingTimer)
        }
        return errors.isEmpty
    }
}


