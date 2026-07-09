import SwiftUI

struct TimerRunningView: View {
    let vm: TimerVM
    var body: some View {
        HStack {
            Text("\(vm.remainingHours)")
            Text(":")
            Text("\(vm.remainingMinutes)")
            Text(":")
            Text("\(vm.remainingSeconds)")
        }
    }
}
