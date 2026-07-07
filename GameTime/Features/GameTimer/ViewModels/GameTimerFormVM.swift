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

/// `GameTimerFormVM` is a form responsible for:
/// - Creation and edit of new and saved timers
/// `name` is a display variable for the created/edited timers name
/// `timer` is a display variable that is converted from string to double.
/// `mode` determins which action is being performed by the user to determin how the sumbission should be handled.
/// `validate()` validates user input returning a boolean value.
/// `onSubmit` is a optional callback defined in `GameTimerVM` where it is saved after create/edit.
@MainActor
@Observable
final class GameTimerFormVM {
    var draft: GameTimer.Draft
    var name: String? = ""
    var timeComponents = TimeComponents()
    var mode: FormMode
    var onSubmit: ((GameTimer.Draft) -> Void)?
    
    init(
        draft: GameTimer.Draft,
        mode: FormMode,
        onSubmit: ((GameTimer.Draft) -> Void)?
    ) {
        self.draft = draft
        self.mode = mode
        self.onSubmit = onSubmit
        
        if mode == .edit {
            name = draft.name
            if let seconds = draft.timer {
                let converted = TimeConverter.convertFromSeconds(seconds)
                timeComponents.seconds = converted.seconds
                timeComponents.minutes = converted.minutes
                timeComponents.hours = converted.hours
            }
        }
        
    }
    
    func submit() {
        draft.name = name
        draft.timer = TimeConverter.convertToSeconds(time: timeComponents)
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

extension GameTimerFormVM: Hashable {
    static func ==(lhs: GameTimerFormVM, rhs: GameTimerFormVM) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

// callbacks can be in views to keep passing viewmodels just for view access to functions

// toolbars can be in switch statements attached to composable views

// create boundaries purposfully with with state driven navigation

// add the isEdit() as a bool that checks if id is nill on the model itself instead of mode
// 
