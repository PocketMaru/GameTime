import SwiftUI

struct CurrentTimerListView: View {
    let currentTimers: [CurrentTimer]
    let delete: (CurrentTimer.ID) -> Void
    let showDetails: (CurrentTimer.ID) -> Void
    let timerAction: (CurrentTimer) -> Void
    var body: some View {
        if !currentTimers.isEmpty {
            Text("Resents")
                .foregroundStyle(Color.primaryText)
                .font(.title2)
                .frame(alignment: .leading)
                .padding(5)
            Divider()
        }
        ForEach(currentTimers) { timer in
            Button{
                showDetails(timer.id)
            } label: {
                VStack {
                    CurrentTimerRowView(
                        currentTimer: timer,
                        timerAction: {
                            timerAction(timer)
                        }
                    )
                    showDivider(currentTimers)
                }
            }
            .swipeActions {
                Button(role: .destructive) {
                    delete(timer.id)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}

@ViewBuilder
private func showDivider(_ timers: [CurrentTimer]) -> some View {
    if !timers.isEmpty {
        Divider()
    }
}
