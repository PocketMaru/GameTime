import Foundation

@MainActor
@Observable
final class TimerVM {
    
    private var originalSeconds: Int
    private var remainingSeconds: Int
    private var taskRunning: Task<Void, Never>?
    var isRunning: Bool {
        taskRunning != nil
    }
    
    init(seconds: Int) {
        self.remainingSeconds = seconds
        self.originalSeconds = seconds
    }
    var secondsRemaining: Int {
        remainingSeconds % 60
    }
    
    var minutesRemaining: Int {
        remainingSeconds % 3600 / 60
    }
    
    var hourRemaining: Int {
        remainingSeconds / 3600
    }
    
    func startTimer() {
        taskRunning = Task {
            do {
                while remainingSeconds > 0 && !Task.isCancelled {
                    try await Task.sleep(for: .seconds(1))
                    remainingSeconds -= 1
                    if remainingSeconds == 0 {
                        pauseTimer()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func pauseTimer() {
        taskRunning?.cancel()
        taskRunning = nil
    }
    
    func resetTimer() {
        pauseTimer()
        remainingSeconds = originalSeconds
    }
    
    func cancel() {
        taskRunning?.cancel()
        taskRunning = nil
        remainingSeconds = 0
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
