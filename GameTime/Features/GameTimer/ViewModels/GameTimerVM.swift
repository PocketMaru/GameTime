import Foundation
import Observation

// Hashable and identifiable required for sheet navigation,
// Hashable is a requirement for identifiable.
@MainActor
enum GameTimerSheet: Hashable, Identifiable {
    case create(GameTimerFormVM)
    case edit(GameTimerFormVM)
    case detail(GameTimer)
    case timer(TimerVM)
    var id: String {
        switch self {
        case .create: return "create"
        case .edit: return "edit"
        case .detail: return "detail"
        case .timer: return "timer"
        }
    }
}

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
    var timeComponents = TimeComponents(
        seconds: 0,
        minutes: 0,
        hours: 1
    )
    var sheet: GameTimerSheet?
    var draft = GameTimer.Draft()
    
    func selectedTimerButtonPressed(_ counter: GameTimer) {
        let timer = TimerVM(seconds: counter.timer)
        sheet = .timer(timer)
    }
    
    func loadQuickTimerButtonPressed() {
        let seconds = TimeConverter.convertToSeconds(time: timeComponents)
        let timer = TimerVM(seconds: seconds)
        sheet = .timer(timer)
    }
    
    func createButtonPressed() {
        sheet = .create(makeForm(gameTimer: .init()))
    }
    
    func editButtonPressed(_ gameTimer: GameTimer) {
        sheet = .edit(makeForm(gameTimer: .init(gameTimer)))
    }
    
    func detailButtonPressed(_ counter: GameTimer) {
        sheet = .detail(counter)
    }
    
    func deleteButtonPressed(counterID: GameTimer.ID) {
        gameTimers.removeAll(where: { $0.id == counterID })
    }
    
    func timerViewDismissed() {
        sheet = nil
    }
 
    private func confirmCreate(gameTimer: GameTimer) {
        gameTimers.append(gameTimer)
        sheet = nil
    }
    
    private func confirmEdit(gameTimer: GameTimer) throws {
        guard let index = gameTimers.firstIndex(where: { $0.id == gameTimer.id } ) else {
            throw GameTimerError.gameTimerNotFound
        }
        gameTimers[index] = gameTimer
        sheet = nil
    }
    
    private func makeForm(gameTimer: GameTimer.Draft) -> GameTimerFormVM {
        return GameTimerFormVM(
            draft: gameTimer,
            onSubmit: { [weak self] draft in
                guard let self else { return }
                if draft.formState == .create {
                    do {
                        try confirmCreate(gameTimer: draft.toModel())
                    } catch {
                        print(error)
                    }
                } else if draft.formState == .update {
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
