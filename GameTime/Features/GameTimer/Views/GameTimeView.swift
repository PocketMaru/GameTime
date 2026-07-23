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
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                ScrollView {
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
                                stop: { vm.cancelButtonPressed() }
                            )
                            
                            TimerNameView(
                                name: $name
                            )
                            
                        } else {
                            CurrentTimerListView(
                                currentTimers: vm.currentTimers,
                                delete: vm.deleteCurrentTimerButtonPressed,
                                showDetails: vm.detailButtonPressed,
                                timerAction: vm.currentTimerButtonPressed,
                            )
                        }
                        ResentTimerListView(
                            resentTimers: vm.resentTimers,
                            delete: vm.deleteResentTimerButtonPressed,
                            timerAction: vm.resentTimerButtonPressed
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Game Time")
                        .font(.largeTitle)
                        .foregroundStyle(Color.primaryText)
                }
                if vm.currentTimers.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Edit") {
                            // mass delete selection
                        }
                    }
                } else {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Edit") {
                            // mass delete selection
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("plus") {
                            vm.createButtonPressed()
                        }
                    }
                }
            }
            .navigationDestination(for: CurrentTimer.self) { timer in
                NavigationStack {
                    GameTimerDetailView(
                        currentTimer: timer,
                    )
                }
            }
            .sheet(item: $vm.sheet) { item in
                switch item {
                case .create:
                    NavigationStack {
                        CurrentTimerAddView(
                            name: $name,
                            timeComponents: $timeComponents,
                            vm: vm
                        )
                    }
                }
            }
            

        }
    }
}
