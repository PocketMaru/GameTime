import SwiftUI

struct GameTimeView: View {
    @Bindable var vm: GameTimerVM
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TimerPickerView(
                    selectedSeconds: $vm.timeComponents.seconds,
                    selectedMinutes: $vm.timeComponents.minutes,
                    selectedHours: $vm.timeComponents.hours
                )
                Button("Start Timer") {
                    vm.goToTimer()
                    vm.loadQuickTimer()
                    vm.startPressed()
                }
                List {
                    ForEach(vm.gameTimers) { timer in
                        Button{
                            vm.goToDetail(timer)
                        } label: {
                            GameTimeRowView(
                                gameTimer: timer,
                                vm: vm
                            )
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                try? vm.confirmDelete(counterID: timer.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Game Time")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        vm.goToCreate()
                    }
                }
            }
            .sheet(item: $vm.sheet) { item in
                switch item {
                case .create:
                    NavigationStack {
                        if let form = vm.activeForm {
                            GameTimeFormView(form: form)
                        }
                    }
                case .edit:
                    NavigationStack {
                        if let form = vm.activeForm {
                            GameTimeFormView(form: form)
                        }
                    }
                case .detail(let timer):
                    NavigationStack {
                        GameTimerDetailView(
                            vm: vm,
                            gameTimer: timer,
                        )
                    }
                case .timer:
                    NavigationStack {
                        TimerView(vm: vm)
                    }
                }
            }
        }
    }
}
