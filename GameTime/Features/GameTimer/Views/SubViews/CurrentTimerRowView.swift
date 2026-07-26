import SwiftUI

struct CurrentTimerRowView: View {
    let currentTimer: CurrentTimer
    let timerAction: () -> Void
    var body: some View {
        HStack(spacing: 10) {
            TimerDisplayView(
                secondsRemaining: currentTimer.timer.secondsRemaining,
                name: currentTimer.model.name,
            )
            Button {
                timerAction()
            } label: {
                ProgressLabelRowAnimation(
                    progress: Double(currentTimer.timer.progress),
                    secondsRemaining: currentTimer.timer.secondsRemaining,
                    isRunning: currentTimer.timer.isRunning
                )
            }
        }
        .padding(.horizontal, 12)
    }
}
