import SwiftUI

struct StartStopButtonView: View {
    let start: () -> Void
    let stop: () -> Void
    let isRunning: Bool
    var body: some View {
        HStack(spacing: 160) {
            Button {
                stop()
            } label: {
                Circle()
                    .fill(Color.secondaryAction).opacity(0.7)
                    .frame(width: 60, height: 60)
                    .overlay {
                        Text("Cancel")
                            .foregroundStyle(Color.secondaryText)
                            .opacity(0.7)
                    }
            }
            Button {
                start()
            } label: {
                Circle()
                    .fill(Color.primaryAction).opacity(0.7)
                    .frame(width: 60, height: 60)
                    .overlay {
                        Text(isRunning ? "Pause" : "Start")
                            .foregroundStyle(Color.primaryText)
                            .opacity(0.7)
                    }
            }
        }
        .padding(10)
    }
}
