import SwiftUI

struct GameTimerDetailView: View {
    let gameTimer: GameTimer
    @Bindable var vm: GameTimerVM
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(gameTimer.name)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text(gameTimer.timer.description)
                .font(.headline)
                .multilineTextAlignment(.center)
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
