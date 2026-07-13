import SwiftUI

struct GameTimeRowView: View {
    let gameTimer: GameTimer
    let timerSelected: (GameTimer) -> Void
    var body: some View {
        HStack(spacing: 10) {
            TimerDisplayView(
                name: gameTimer.name,
                seconds: gameTimer.timer
            )
            Button {
                timerSelected(gameTimer)
            } label: {
                Image(systemName: "timer.circle")
            }
        }
    }
}
