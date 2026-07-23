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
        if currentTimer.timer.isRunning {
            currentTimer.timer.pause()
        } else {
            currentTimer.timer.start()
        }
    }
    
    func currentTimerStartButtonPressed(_ currentTimer: CurrentTimer) {
        if !currentTimer.timer.isRunning {
            currentTimer.timer.start()
        }
    }
    
    func resentTimerButtonPressed(_ model: GameTimer) {
        let currentTimer = CurrentTimer(
            model: model,
            timer: TimerVM(seconds: model.timer)
        )
        currentTimers.append(currentTimer)
        currentTimer.timer.start()
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
        
        currentTimer.timer.start()
        
        if currentTimer.timer.secondsRemaining == 0 {
            currentTimers.removeAll(where: { $0.id == currentTimer.id })
        }
    }
    
    private func dismissSheet() {
        sheet = nil
    }
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
