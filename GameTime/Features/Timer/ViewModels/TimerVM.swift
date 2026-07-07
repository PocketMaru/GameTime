import Foundation

@MainActor
@Observable
final class TimerVM {
    
    private var originalSeconds: Int = 0
    private var remainingSeconds: Int = 0
    private var taskRunning: Task<Void, Never>?
    var isRunning: Bool = false
    
    var secondsRemaining: Int {
        remainingSeconds % 60
    }
    
    var minutesRemaining: Int {
        remainingSeconds % 3600 / 60
    }
    
    var hourRemaining: Int {
        remainingSeconds / 3600
    }
    
    func load(seconds: Int) {
        remainingSeconds = seconds
        originalSeconds = seconds
    }
    
    func startTimer() {
        isRunning = true
        taskRunning = Task {
            defer {
                isRunning = false
            }
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
    }
    
    func resetTimer() {
        pauseTimer()
        remainingSeconds = originalSeconds
    }
    
    func cancel() {
        taskRunning?.cancel()
        remainingSeconds = 0
    }
}
