import Foundation

@MainActor
@Observable
final class TimerVM {
    
    private(set) var secondsRemaining: Int
    private var originalSeconds: Int
    private var taskRunning: Task<Void, Never>?
    
    var onComplete: (() -> Void)?
    var progress: Double {
        Double(secondsRemaining) / Double(originalSeconds)
    }
    
    var isRunning: Bool {
        taskRunning != nil
    }
    
    init(seconds: Int) {
        self.secondsRemaining = seconds
        self.originalSeconds = seconds
    }
    
    func start() {
        taskRunning = Task {
            do {
                while secondsRemaining > 0 && !Task.isCancelled {
                    try await Task.sleep(for: .seconds(1))
                    secondsRemaining -= 1
                    if secondsRemaining == 0 {
                        taskCompleted()
                        onComplete?()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func toggleTimerControl() {
        if isRunning {
            pause()
        } else {
            start()
        }
    }
    
    func pause() {
        taskRunning?.cancel()
        taskRunning = nil
    }
    
    func cancel() {
        taskRunning?.cancel()
        taskRunning = nil
        secondsRemaining = 0
    }
    
    private func taskCompleted() {
        taskRunning?.cancel()
        taskRunning = nil
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
