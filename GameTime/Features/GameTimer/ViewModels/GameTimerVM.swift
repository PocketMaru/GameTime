import Foundation
import Observation

// Hashable and identifiable required for sheet navigation,
// Hashable is a requirement for identifiable.
enum GameTimerSheet: Hashable, Identifiable {
    case create
    case edit
    case detail(GameTimer)
    case timer
    var id: String {
        switch self {
        case .create: return "create"
        case .edit: return "edit"
        case .detail: return "detail"
        case .timer: return "timer"
        }
    }
}

/// `GameTimerVM` is a  feature responsible for:
/// - Navigation to and from the `Edit` and `Add` modals.
/// - display of user input for a timer.
/// - Creating, deleting, and editing of a users saved timer.
/// - Starting, Pausing, and Resetting of the timer.
/// Holds reference to `GameTimerFormVM` through callback for submission of ner/edited timers.
/// `taskRunning` is a `Task`used to simulate the count down of the timer using `.sleep`
@MainActor
@Observable
final class GameTimerVM {
    var gameTimers: [GameTimer] = []
    var sheet: GameTimerSheet?
    var selectedTimer: GameTimer?
    var activeForm: GameTimerFormVM?
    var timer = TimerVM()
    var timeComponents = TimeComponents()
    
    func gameTimerSelected(_ counter: GameTimer) {
        selectedTimer = counter
        timer.load(seconds: counter.timer)
        sheet = .timer
    }
    
    func loadQuickTimer() {
        if selectedTimer == nil {
            let seconds = TimeConverter.convertToSeconds(time: timeComponents)
            timer.load(seconds: seconds)
        }
    }
    
    func startPressed() {
        timer.startTimer()
    }
    
    func pausePressed() {
        timer.pauseTimer()
    }
    
    func resetPressed() {
        timer.resetTimer()
    }
    
    func cancelPressed() {
        timer.cancel()
        sheet = nil
    }
    
    func goToTimer() {
        sheet = .timer
    }
    
    func goToCreate() {
        let draft = GameTimer.Draft(id: UUID())
        activeForm = makeForm(gameTimer: draft, mode: .create)
        sheet = .create
    }
    
    func goToEdit(_ counter: GameTimer) {
        activeForm = makeForm(gameTimer: counter.toDraft(), mode: .edit)
        sheet = .edit
    }
    
    func goToDetail(_ counter: GameTimer) {
        sheet = .detail(counter)
    }
    
    func confirmCreate(gameTimer: GameTimer) {
        gameTimers.append(gameTimer)
        sheet = nil
    }
    
    func confirmEdit(gameTimer: GameTimer) throws {
        guard let index = gameTimers.firstIndex(where: { $0.id == gameTimer.id } ) else {
            throw GameTimerError.gameTimerNotFound
        }
        gameTimers[index] = gameTimer
        sheet = nil
    }
    
    func confirmDelete(counterID: UUID) throws {
        gameTimers.removeAll(where: { $0.id == counterID })
    }
    
    func makeForm(gameTimer: GameTimer.Draft, mode: FormMode) -> GameTimerFormVM {
        print("MAKE FORM CALLED")
        return GameTimerFormVM(
            draft: gameTimer,
            mode: mode,
            onSubmit: { [weak self] draft in
                guard let self else { return }
                if mode == .create {
                    do {
                        try confirmCreate(gameTimer: draft.toModel())
                    } catch {
                        print(error)
                    }
                } else if mode == .edit {
                    do {
                        try confirmEdit(gameTimer: draft.toModel())
                    } catch {
                        print(error)
                    }
                }
            }
        )
    }
}
