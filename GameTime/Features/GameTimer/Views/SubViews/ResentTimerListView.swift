import SwiftUI

struct ResentTimerListView: View {
    let resentTimers: [GameTimer]
    let delete: (GameTimer.ID) -> Void
    let timerAction: (GameTimer) -> Void
    var body: some View {
        if !resentTimers.isEmpty {
            Text("Resents")
                .foregroundStyle(Color.primaryText)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
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
