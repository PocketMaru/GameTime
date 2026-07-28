import SwiftUI

struct GameTimeView: View {
    @Bindable var vm: GameTimerVM
    @State private var name: String = ""
    @State private var timeComponents = TimeComponents(
        seconds: 0,
        minutes: 0,
        hours: 1
    )
    var body: some View {
        NavigationStack(path: $vm.path) {
            VStack(spacing: 20) {
                if vm.currentTimers.isEmpty {
                    TimerPickerView(
                        selectedSeconds: $timeComponents.seconds,
                        selectedMinutes: $timeComponents.minutes,
                        selectedHours: $timeComponents.hours,
                    )
                    
                    StartStopButtonView(
                        start: { vm.startNewTimerButtonPressed(
                            name: name,
                            timeComponents: timeComponents
                        )},
                        stop: { vm.cancelButtonPressed() },
                        isRunning: false
                    )
                    
                    TimerNameView(
                        name: $name
                    )
                }
                TimerListView(
                    currentTimers: vm.currentTimers,
                    recentTimers: vm.recentTimers,
                    deleteCurrent: vm.deleteCurrentTimerButtonPressed,
                    deleteRecent: vm.deleteRecentTimerButtonPressed,
                    deleteCurrentTimers: vm.deleteCurrentTimers,
                    deleteRecentTimers: vm.deleteRecentTimers,
                    currentTimerAction: vm.currentTimerRowButtonPressed,
                    recentTimerAction: vm.recentTimerButtonPressed,
                    showDetails: vm.detailButtonPressed
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.background))
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Game Time")
                        .font(.largeTitle)
                        .foregroundStyle(Color.primaryText)
                }
                if vm.currentTimers.isEmpty && vm.recentTimers.isEmpty {
                    EmptyView()
                } else if vm.currentTimers.isEmpty && !vm.recentTimers.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            vm.createButtonPressed()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .navigationDestination(for: CurrentTimer.self) { timer in
                GameTimerDetailView(
                    currentTimer: timer,
                    start: { vm.pauseButtonPressed(timer) },
                    stop: { vm.cancelButtonPressed(timer) },
                    save: { name in
                        vm.saveNameButtonPressed(timer: timer, name: name)
                    }
                )
            }
            .sheet(item: $vm.sheet) { item in
                switch item {
                case .create:
                    NavigationStack {
                        CurrentTimerAddView(
                            vm: vm
                        )
                    }
                }
            }
        }
    }
}
