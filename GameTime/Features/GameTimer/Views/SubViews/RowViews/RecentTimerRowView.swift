import SwiftUI

struct RecentTimerRowView: View {
    let recentTimer: GameTimer
    let timerAction: () -> Void
    var body: some View {
        HStack(spacing: 10) {
            TimerDisplayView(
                secondsRemaining: recentTimer.timer,
                name: recentTimer.name,
            )
            Button {
                timerAction()
            } label: {
                Circle()
                    .fill(Color.primaryAction).opacity(0.7)
                    .frame(width: 60, height: 60)
                    .overlay {
                        Image(systemName: "play.fill")
                            .foregroundStyle(Color.primaryText)
                            .opacity(0.7)
                    }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 10)
    }
}

