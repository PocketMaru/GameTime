import SwiftUI

struct GameTimeView: View {
    @Bindable var vm: GameTimerVM
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Current Game Timer")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                Text("\(vm.timeRemaining)")
                    .font(.largeTitle)
                    .padding(10)
                Text("Set Timer")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                TextField("Set Timer", text: $vm.timeRemaining)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(10)
                if !vm.isRunning {
                    Button("Start Timer") {
                        vm.startTimer()
                    }
                } else {
                    Button("Pause") {
                        vm.pauseTimer()
                    }
                }
                Button("Reset") {
                    vm.resetTimer()
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
                    let create = GameTimer.Draft(id: UUID())
                    let form = vm.makeForm(gameTimer: create, mode: .create)
                    NavigationStack {
                        GameTimeFormView(form: form)
                    }
                case .edit(let timer):
                    let form = vm.makeForm(gameTimer: timer.toDraft(), mode: .edit)
                    NavigationStack {
                        GameTimeFormView(form:form)
                    }
                case .detail(let timer):
                    NavigationStack {
                        GameTimerDetailView(gameTimer: timer, vm: vm)
                    }
                }
            }
        }
    }
}
