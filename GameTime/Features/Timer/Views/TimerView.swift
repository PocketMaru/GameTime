import SwiftUI

struct TimerView: View {
    let vm: TimerVM
    let dismiss: () -> Void
    var body: some View {
        TimerRunningView(vm: vm)
        if vm.isRunning {
            Button("Pause") {
                vm.pauseButtonPressed()
            }
        } else {
            Button("Start") {
                vm.startButtonPressed()
            }
        }
        Button("Reset") {
            vm.resetButtonPressed()
        }
        Button("Return") {
            vm.cancelButtonPressed()
            dismiss()
        }
    }
}
