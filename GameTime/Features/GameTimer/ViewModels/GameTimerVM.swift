import Foundation
import Observation

enum GameTimerError: Error {
    case gameTimerNotFound
    case missingTimer
    case failedModelConversion
    case missingID
}

// Hashable and identifiable required for sheet navigation,
// Hashable is a requirement for identifiable.
@MainActor
enum GameTimerSheet: Hashable, Identifiable {
    case create
    var id: String {
        switch self {
        case .create: return "create"
        }
    }
}

@MainActor
@Observable
final class GameTimerVM {
    var currentTimers: [CurrentTimer] = []
    var resentTimers: [GameTimer] = []
    var sheet: GameTimerSheet?
    var path: [CurrentTimer] = []
    
    func startNewTimerButtonPressed(
        name: String,
        timeComponents: TimeComponents
    ) {
        createTimer(
            name: name,
            timeComponents: timeComponents
        )
        if sheet != nil {
            dismissSheet()
        }
        
    }
    
    func currentTimerRowButtonPressed(_ currentTimer: CurrentTimer) {
        timerController(currentTimer)
        onCompleteAction(currentTimer)
    }
    
    func pauseButtonPressed(_ currentTimer: CurrentTimer) {
        timerController(currentTimer)
    }
    
    func resentTimerButtonPressed(_ model: GameTimer) {
        let currentTimer = CurrentTimer(
            model: model,
            timer: TimerVM(seconds: model.timer)
        )
        currentTimers.append(currentTimer)
        currentTimer.timer.start()
        onCompleteAction(currentTimer)
        if sheet != nil {
            dismissSheet()
        }
    }
    
    func saveNameButtonPressed(timer: CurrentTimer, name: String) {
        if let index = resentTimers.firstIndex(of: timer.model) {
            resentTimers[index].name = name
            if let index = currentTimers.firstIndex(of: timer) {
                currentTimers[index].model.name = name
            }
        }
    }
    
    func createButtonPressed() {
        sheet = .create
    }
    
    func detailButtonPressed(model: CurrentTimer.ID) {
        guard let timer = currentTimers.first(where: { $0.id == model }) else { return }
        path.append(timer)
    }
    
    func dismissSheetButtonPressed() {
        dismissSheet()
    }
    
    
    func cancelButtonPressed(_ timer: CurrentTimer? = nil) {
        guard let timer else { return }
        timer.timer.cancel()
        currentTimers.removeAll(where: { $0.id == timer.id })
        path.removeAll()
    }
    
    func deleteResentTimerButtonPressed(counterID: GameTimer.ID) {
        resentTimers.removeAll(where: { $0.id == counterID })
    }
    
    func deleteCurrentTimerButtonPressed(counterID: CurrentTimer.ID) {
        currentTimers.removeAll(where: { $0.id == counterID })
    }
 
// MARK: - Private Access Functions
    
    /// - Creates a new `CurrentTimer` object.
    /// - Creates a name based on the selected timer if the label is empty.
    /// - Parameters:
    ///   - name: String representing the name of the timer, if the value is empty is it assigned based on `timeComponents`.
    ///   - timeComponents: Data type structureing the users selected timer.
    private func createTimer(
        name: String,
        timeComponents: TimeComponents
    ) {
        guard validate(
            timeComponents: timeComponents
        ) else { return }
        
        let finalName = name.isEmpty ? TimeConverter.toLabel(timeComponents) : name
        
        let model = GameTimer(
            id: UUID(),
            name: finalName,
            timer: TimeConverter.convertToSeconds(time: timeComponents)
        )
        
        let currentTimer = CurrentTimer(
            model: model,
            timer: TimerVM(seconds: model.timer)
        )
        
        let exists = resentTimers.contains {
            $0.timer == model.timer &&
            $0.name == model.name
        }
        
        currentTimers.append(currentTimer)
        
        if !exists {
            resentTimers.append(model)
        }
        
        timerController(currentTimer)
        onCompleteAction(currentTimer)
    }
    
    
    /// - Creates a toggle for the timer based on its current state.
    /// - Parameter timer: `CurrentTimer` object holds its own `TimerVM`, allowing control of individual timers just by passing the object.
    private func timerController(_ timer: CurrentTimer) {
        if timer.timer.isRunning {
            timer.timer.pause()
        } else {
            timer.timer.start()
        }
    }
    
    /// - Callback function allowing a `CurrentTimer` object to notify when it has completed.
    /// - Holds weak reference to self due to `TimerVM` being a reference type.
    /// - On completion of a `CurrentTimer`, it is removed from the current timers.
    /// - Parameter currentTimer: Takes in a `CurrentTimerObject`
    private func onCompleteAction(_ currentTimer: CurrentTimer) {
        currentTimer.timer.onComplete = { [weak self] in
            guard let self else { return }
            currentTimers.removeAll(where: { $0.id == currentTimer.id })
        }
    }
    
    /// - Dismissal of the `GameTimerSheet`
    private func dismissSheet() {
        sheet = nil
    }
    
    
    /// - Validates the users time input to ensure it is greater than zero seconds.
    /// - Parameter timeComponents: Data type structuring the users selected timer.
    /// - Returns: A `Boolean` value based on `GameTimerError`'s caught.
    private func validate(
        timeComponents: TimeComponents
    ) -> Bool {
        var errors: [GameTimerError] = []
        let seconds = TimeConverter.convertToSeconds(time: timeComponents)
        if seconds == 0 {
            errors.append(.missingTimer)
        }
        return errors.isEmpty
    }
}
