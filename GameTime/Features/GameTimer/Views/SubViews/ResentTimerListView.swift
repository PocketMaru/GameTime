import SwiftUI

struct ResentTimerListView: View {
    let resentTimers: [GameTimer]
    let delete: (GameTimer.ID) -> Void
    let timerAction: (GameTimer) -> Void
    var body: some View {
        if !resentTimers.isEmpty {
            Text("Resents")
                .foregroundStyle(Color.primaryText)
                .font(.title2)
                .frame(alignment: .leading)
                .padding(5)
            Divider()
        }
        ForEach(resentTimers) { timer in
            VStack {
                ResentTimerRowView(
                    resentTimer: timer,
                    timerAction: {
                        timerAction(timer)
                    }
                )
                showDivider(resentTimers)
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
private func showDivider(_ timers: [GameTimer]) -> some View {
    if !timers.isEmpty {
        Divider()
    }
}
