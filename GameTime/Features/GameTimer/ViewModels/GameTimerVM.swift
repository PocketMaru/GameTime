import Foundation
import Observation
import SwiftUI

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
    var id: Self { self }
}

@MainActor
@Observable
final class GameTimerVM {
    var currentTimers: [CurrentTimer] = []
    var recentTimers: [GameTimer] = []
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
    
    func startPresetTimerButtonPressed(_ timer: TimeComponents) {
        createTimer(
            name: "",
            timeComponents: timer
        )
        if sheet != nil {
            dismissSheet()
        }
    }
    
    func currentTimerRowButtonPressed(_ currentTimer: CurrentTimer) {
        currentTimer.timer.toggleTimerControl()
        onCompleteAction(currentTimer)
    }
    
    func pauseButtonPressed(_ currentTimer: CurrentTimer) {
        currentTimer.timer.toggleTimerControl()
    }
    
    func recentTimerButtonPressed(_ model: GameTimer) {
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
        guard
            let recentTimerIndex = recentTimers.firstIndex(of: timer.model),
            let currentTimerIndex = currentTimers.firstIndex(of: timer)
        else { return  }
        recentTimers[recentTimerIndex].name = name
        currentTimers[currentTimerIndex].model.name = name
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
    
    func deleteRecentTimerButtonPressed(counterID: GameTimer.ID) {
        recentTimers.removeAll(where: { $0.id == counterID })
    }
    
    func deleteCurrentTimerButtonPressed(counterID: CurrentTimer.ID) {
        currentTimers.removeAll(where: { $0.id == counterID })
    }
    
    func deleteCurrentTimers(at offsets: IndexSet) {
        currentTimers.remove(atOffsets: offsets)
    }

    func deleteRecentTimers(at offsets: IndexSet) {
        recentTimers.remove(atOffsets: offsets)
    }
    
// MARK: - Private Access Functions
    
    // - Creates a new `CurrentTimer` object.
    // - Creates a name based on the selected timer if the label is empty.
    // - Parameters:
    //   - name: String representing the name of the timer, if the value is     empty is it assigned based on `timeComponents`.
    //   - timeComponents: Data type structureing the users selected timer.
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
        
        let exists = recentTimers.contains {
            $0.timer == model.timer &&
            $0.name == model.name
        }
        
        currentTimers.append(currentTimer)
        
        if !exists {
            recentTimers.append(model)
        }
        
        currentTimer.timer.toggleTimerControl()
        onCompleteAction(currentTimer)
    }
    
    private func onCompleteAction(_ currentTimer: CurrentTimer) {
        currentTimer.timer.setupOnCompleteAction = { [weak self] in
            guard let self else { return }
            currentTimers.removeAll(where: { $0.id == currentTimer.id })
        }
    }
    
    // Dismissal of the `GameTimerSheet`
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
