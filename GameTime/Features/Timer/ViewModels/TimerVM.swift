import Foundation

@MainActor
@Observable
final class TimerVM {
    
    private(set) var secondsRemaining: Int
    private var originalSeconds: Int
    private var taskRunning: Task<Void, Never>?
    
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
                        pause()
                    }
                }
            } catch {
                print(error)
            }
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
}

extension TimerVM: Hashable {
    static func == (lhs: TimerVM, rhs: TimerVM) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        ObjectIdentifier(self).hash(into: &hasher)
    }
}
