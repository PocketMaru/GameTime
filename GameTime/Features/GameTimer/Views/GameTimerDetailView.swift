import SwiftUI

struct GameTimerDetailView: View {
    let gameTimer: GameTimer
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TimerDisplayView(
                name: gameTimer.name,
                seconds: gameTimer.timer
            )
        }
    }
}
