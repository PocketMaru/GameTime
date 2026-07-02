import Foundation
import Observation

enum GameTimerSheet: Hashable, Identifiable {
    case create
    case edit(GameTimer)
    case detail(GameTimer)
    
    var id: Self { self }
}

@MainActor
@Observable
final class GameTimerVM {
    var gameTimers: [GameTimer] = []
    var sheet: GameTimerSheet?
    var gameTimer: String = ""
    var taskRunning: Task<Void, Never>?
    
    func goToCreate() {
        sheet = .create
    }
    
    func goToEdit(_ counter: GameTimer) {
        sheet = .edit(counter)
    }
    
    func goToDetail(_ counter: GameTimer) {
        sheet = .detail(counter)
    }
    func timerSelected(_ counter: GameTimer) {
        gameTimer = String(counter.timer)
    }
    
    func startTimer() {
        taskRunning = Task {
            do {
                while Double(gameTimer) ?? 0 > 0 && !Task.isCancelled {
                    try await Task.sleep(for: .seconds(1))
                    if let timer = Double(gameTimer) {
                        gameTimer = String(timer - 1)
                    }
                    if String(gameTimer) == String(0) {
                        stopTimer()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func stopTimer() {
        taskRunning?.cancel()
    }
    
    func resetTimer() {
        gameTimer = ""
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
        guard let index = gameTimers.firstIndex(where: { $0.id == counterID }) else {
            throw GameTimerError.gameTimerNotFound
        }
        gameTimers.remove(at: index)
        gameTimer = ""
    }
    
    func makeForm(gameTimer: GameTimer.Draft, mode: FormMode) -> GameTimerFormVM {
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
