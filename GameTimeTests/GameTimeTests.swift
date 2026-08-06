import Testing
import Foundation
@testable import GameTime

@MainActor
struct GameTimeTests {
    private let vm = GameTimerVM()
    @Test
    func startingSameRecentTimerCreatesUniqueSessions() throws {
        let recentTimer = GameTimer(
            id: UUID(),
            name: "Test",
            timer: 60
        )

        vm.recentTimerButtonPressed(recentTimer)
        vm.recentTimerButtonPressed(recentTimer)

        try #require(vm.currentTimers.count == 2)

        let firstTimer = vm.currentTimers[0]
        let secondTimer = vm.currentTimers[1]

        #expect(firstTimer.id != secondTimer.id)
        #expect(firstTimer.timer !== secondTimer.timer)
    }
    
    @Test
    func pauseAndResumePreservesRemainingTime() async throws {
        let timer = TimerVM(seconds: 10)
        defer { timer.cancel() }

        timer.start()

        try await Task.sleep(for: .milliseconds(1_100))

        timer.pause()
        let remainingWhenPaused = timer.secondsRemaining

        #expect(remainingWhenPaused < 10)

        try await Task.sleep(for: .milliseconds(1_100))

        #expect(timer.secondsRemaining == remainingWhenPaused)

        timer.start()

        try await Task.sleep(for: .milliseconds(1_100))

        timer.pause()

        #expect(timer.secondsRemaining < remainingWhenPaused)
    }
}
