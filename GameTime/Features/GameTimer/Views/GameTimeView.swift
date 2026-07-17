import SwiftUI

struct GameTimeView: View {
    @Bindable var vm: GameTimerVM
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        TimerPickerView(
                            selectedSeconds: $vm.timeComponents.seconds,
                            selectedMinutes: $vm.timeComponents.minutes,
                            selectedHours: $vm.timeComponents.hours,
                            name: $vm.draft.name.unwrap()
                        )
                        Button("Quick Timer") {
                            vm.loadQuickTimerButtonPressed()
                        }
                        Text("Resents")
                        GameTimerListView(
                            gameTimers: vm.gameTimers,
                            delete: vm.deleteButtonPressed,
                            showDetails: vm.detailButtonPressed,
                            select: vm.selectedTimerButtonPressed
                        )
                    }
                }
            }
            .navigationTitle("Game Time")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        vm.createButtonPressed()
                    }
                }
            }
            .sheet(item: $vm.sheet) { item in
                switch item {
                case .create(let form):
                    NavigationStack {
                        GameTimeFormView(form: form)
                    }
                case .edit(let form):
                    NavigationStack {
                        GameTimeFormView(form: form)
                    }
                case .detail(let timer):
                    NavigationStack {
                        GameTimerDetailView(
                            gameTimer: timer,
                        )
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Edit") {
                                    vm.editButtonPressed(timer)
                                }
                            }
                        }
                    }
                case .timer(let timerVM):
                    NavigationStack {
                        TimerView(
                            vm: timerVM,
                            dismiss: {vm.timerViewDismissed()}
                        )
                        .presentationDragIndicator(.visible)
                    }
                }
            }
        }
    }
}
