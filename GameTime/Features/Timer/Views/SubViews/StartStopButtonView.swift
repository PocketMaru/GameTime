import SwiftUI

struct StartStopButtonView: View {
//    let startButton: () -> Void
//    let stopButton: () -> Void
    var body: some View {
        HStack(spacing: 160) {
            Button {
                /*stopButton*/()
            } label: {
                Circle()
                    .fill(Color.secondaryAction).opacity(0.7)
                    .frame(width: 60, height: 60)
                    .overlay {
                        Text("Cancel")
                            .foregroundStyle(Color.secondaryText).opacity(0.7)
                    }
            }
            Button {
                /*startButton*/()
            } label: {
                Circle()
                    .fill(Color.primaryAction).opacity(0.7)
                    .frame(width: 60, height: 60)
                    .overlay {
                        Text("Start")
                            .foregroundStyle(Color.primaryText).opacity(0.7)
                    }
            }
        }
        .padding(10)
    }
}
