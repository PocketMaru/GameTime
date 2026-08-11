import SwiftUI

struct CurrentTimerAddView: View {
    @State private var name: String = ""
    @State private var timeComponents: TimeComponents = TimeComponents(
        seconds: 0,
        minutes: 0,
        hours: 1
    )
    let vm: GameTimerVM
    var body: some View {
        VStack(spacing: 10) {
            TimerPickerView(
                selectedSeconds: $timeComponents.seconds,
                selectedMinutes: $timeComponents.minutes,
                selectedHours: $timeComponents.hours,
            )
            
            TimerNameView(
                name: $name
            )
            
            PresetTimerRowView(action: vm.startPresetTimerButtonPressed)
            
            RecentTimerListView(
                recentTimers: vm.recentTimers,
                delete: vm.deleteRecentTimerButtonPressed,
                timerAction: vm.recentTimerButtonPressed,
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.background))
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(role: .close) {
                    vm.dismissSheetButtonPressed()
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Timer")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.startNewTimerButtonPressed(
                        name: name,
                        timeComponents: timeComponents
                    )
                } label: {
                    Image(systemName: "play.fill")
                }
            }
        }
    }
}
