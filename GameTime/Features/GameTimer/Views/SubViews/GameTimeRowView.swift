import SwiftUI

struct GameTimeRowView: View {
    let gameTimer: GameTimer
    @Bindable var vm: GameTimerVM
    var body: some View {
        HStack(spacing: 10) {
            TimerDisplayView(
                name: gameTimer.name,
                seconds: gameTimer.timer
            )
            Button {
                vm.gameTimerSelected(gameTimer)
            } label: {
                Image(systemName: "play.fill")
            }
        }
    }
}
