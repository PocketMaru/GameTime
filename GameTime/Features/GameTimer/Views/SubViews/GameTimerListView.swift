import SwiftUI

struct GameTimerListView: View {
    let gameTimers: [GameTimer]
    let delete: (GameTimer.ID) -> Void
    let showDetails: (GameTimer) -> Void
    let select: (GameTimer) -> Void
    var body: some View {
        ForEach(gameTimers) { timer in
            Button{
                showDetails(timer)
            } label: {
                VStack {
                    GameTimeRowView(
                        gameTimer: timer,
                        timerSelected: { timer in
                            select(timer)
                        }
                    )
                    showDivider(gameTimers)
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
func showDivider(_ timers: [GameTimer]) -> some View {
    if !timers.isEmpty {
        Divider()
    }
}
