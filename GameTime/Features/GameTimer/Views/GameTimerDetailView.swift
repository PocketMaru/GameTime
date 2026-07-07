import SwiftUI

struct GameTimerDetailView: View {
    @Bindable var vm: GameTimerVM
    let gameTimer: GameTimer
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TimerDisplayView(
                name: gameTimer.name,
                seconds: gameTimer.timer
            )
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    vm.goToEdit(gameTimer)
                }
            }
        }
    }
}
