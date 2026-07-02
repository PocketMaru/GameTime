import SwiftUI

struct GameTimeRowView: View {
    let gameTimer: GameTimer
    @Bindable var vm: GameTimerVM
    var body: some View {
        HStack {
            Text(gameTimer.name)
            Spacer()
            Text(gameTimer.timer.description)
            Spacer()
            Button("Select") {
                vm.timerSelected(gameTimer)
            }
        }
    }
}
