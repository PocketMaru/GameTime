import SwiftUI

enum TimerSelection: Hashable {
    case current(CurrentTimer.ID)
    case recent(GameTimer.ID)
}

struct TimerListView: View {
    @Binding var selectedTimers: Set<TimerSelection>
    
    let currentTimers: [CurrentTimer]
    let recentTimers: [GameTimer]
    
    let deleteCurrent: (CurrentTimer.ID) -> Void
    let deleteRecent: (GameTimer.ID) -> Void
    
    let currentTimerAction: (CurrentTimer) -> Void
    let recentTimerAction: (GameTimer) -> Void
    
    let showDetails: (CurrentTimer.ID) -> Void
    
    
    var body: some View {
        List(selection: $selectedTimers) {
            if !currentTimers.isEmpty {
                Section {
                    ForEach(currentTimers) { timer in
                        Button{
                            showDetails(timer.id)
                        } label: {
                            CurrentTimerRowView(
                                currentTimer: timer,
                                timerAction: {
                                    currentTimerAction(timer)
                                }
                            )
                            
                            .swipeActions {
                                Button(role: .destructive) {
                                    deleteCurrent(timer.id)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .tag(TimerSelection.current(timer.id))
                        .listRowBackground(Color.background)
                    }
                } header: {
                    Text("Timers")
                        .foregroundStyle(Color.primaryText)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
            }
            if !recentTimers.isEmpty {
                Section {
                    ForEach(recentTimers) { timer in
                        RecentTimerRowView(
                            recentTimer: timer,
                            timerAction: {
                                recentTimerAction(timer)
                            }
                        )
                        .tag(TimerSelection.recent(timer.id))
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteRecent(timer.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .listRowBackground(Color.background)
                    }
                } header: {
                    Text("Resents")
                        .foregroundStyle(Color.primaryText)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
            }
        }
        .listStyle(.plain)
    }
}
