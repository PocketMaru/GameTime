import SwiftUI

struct TimerView: View {
    @Bindable var vm: GameTimerVM
    var body: some View {
        TimerRunningView(vm: vm.timer)
        if vm.timer.isRunning {
            Button("Pause") {
                vm.pausePressed()
            }
        } else {
            Button("Start") {
                vm.startPressed()
            }
        }
        Button("Reset") {
            vm.resetPressed()
        }
        Button("Return") {
            vm.cancelPressed()
        }
    }
}
