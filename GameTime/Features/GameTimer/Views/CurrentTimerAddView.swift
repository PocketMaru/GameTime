import SwiftUI

struct CurrentTimerAddView: View {
    @Binding var name: String
    @Binding var timeComponents: TimeComponents
    let vm: GameTimerVM
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack(spacing: 10) {
                    TimerPickerView(
                        selectedSeconds: $timeComponents.seconds,
                        selectedMinutes: $timeComponents.minutes,
                        selectedHours: $timeComponents.hours,
                    )
                    
                    TimerNameView(
                        name: $name
                    )
                
                    // presets view
                
                    ResentTimerListView(
                        resentTimers: vm.resentTimers,
                        delete: vm.deleteResentTimerButtonPressed,
                        timerAction: vm.resentTimerButtonPressed,
                    )
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    vm.dismissSheetButtonPressed()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Timer")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("play.fill") {
                    vm.startNewTimerButtonPressed(
                        name: name,
                        timeComponents: timeComponents
                    )
                }
            }
        }
    }
}
