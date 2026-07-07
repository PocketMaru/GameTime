import SwiftUI

struct TimerRunningView: View {
    @Bindable var vm: TimerVM
    var body: some View {
        HStack {
            Text("\(vm.hourRemaining)")
            Text(":")
            Text("\(vm.minutesRemaining)")
            Text(":")
            Text("\(vm.secondsRemaining)")
        }
    }
}
