import Foundation

@MainActor
@Observable
final class TimerVM {
    
    private var originalSeconds: Int
    private var secondsRemaining: Int
    private var taskRunning: Task<Void, Never>?
    var isRunning: Bool {
        taskRunning != nil
    }
    
    init(seconds: Int) {
        self.secondsRemaining = seconds
        self.originalSeconds = seconds
    }
    
    var remainingSeconds: Int {
        secondsRemaining % 60
    }
    
    var remainingMinutes: Int {
        secondsRemaining % 3600 / 60
    }
    
    var remainingHours: Int {
        secondsRemaining / 3600
    }
    
    func startButtonPressed() {
        taskRunning = Task {
            do {
                while secondsRemaining > 0 && !Task.isCancelled {
                    try await Task.sleep(for: .seconds(1))
                    secondsRemaining -= 1
                    if secondsRemaining == 0 {
                        pauseButtonPressed()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func pauseButtonPressed() {
        taskRunning?.cancel()
        taskRunning = nil
    }
    
    func resetButtonPressed() {
        taskRunning?.cancel()
        taskRunning = nil
        secondsRemaining = originalSeconds
    }
    
    func cancelButtonPressed() {
        taskRunning?.cancel()
        taskRunning = nil
        secondsRemaining = 0
    }
}

extension TimerVM: Hashable {
    static func == (lhs: TimerVM, rhs: TimerVM) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        ObjectIdentifier(self).hash(into: &hasher)
    }
}
