import SwiftUI

struct StartStopButtonView: View {
//    let startButton: () -> Void
//    let stopButton: () -> Void
    var body: some View {
        HStack(spacing: 160) {
            Button {
                /*stopButton*/()
            } label: {
                timerButton(
                    label: "Cancel",
                    actionColor: Color.secondaryAction,
                    textColor: Color.secondaryText
                )
            }
            Button {
                /*startButton*/()
            } label: {
                timerButton(
                    label: "Start",
                    actionColor: Color.primaryAction,
                    textColor: Color.primaryText
                )
            }
        }
        .padding(10)
    }
}
