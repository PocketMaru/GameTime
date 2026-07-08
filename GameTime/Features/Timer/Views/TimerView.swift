import SwiftUI

struct TimerView: View {
    @Bindable var vm: TimerVM
    var isCanceled: (() -> Void)
    var body: some View {
        TimerRunningView(vm: vm)
        if vm.isRunning {
            Button("Pause") {
                vm.pauseTimer()
            }
        } else {
            Button("Start") {
                vm.startTimer()
            }
        }
        Button("Reset") {
            vm.resetTimer()
        }
        Button("Return") {
            vm.cancel()
            isCanceled()
        }
    }
}
