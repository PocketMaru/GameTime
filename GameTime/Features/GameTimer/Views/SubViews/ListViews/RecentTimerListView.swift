import SwiftUI

struct RecentTimerListView: View {
    let recentTimers: [GameTimer]
    let delete: (GameTimer.ID) -> Void
    let timerAction: (GameTimer) -> Void
    var body: some View {
        List(recentTimers) { timer in
            Section {
                RecentTimerRowView(
                    recentTimer: timer,
                    timerAction: {
                        timerAction(timer)
                    }
                )
                .swipeActions {
                    Button(role: .destructive) {
                        delete(timer.id)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                .listRowBackground(Color.background)
            } header: {
                Text("Resents")
                    .foregroundStyle(Color.primaryText)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
        }
        .listStyle(.plain)
    }
}
