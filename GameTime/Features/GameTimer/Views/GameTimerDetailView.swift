import SwiftUI

struct GameTimerDetailView: View {
    var currentTimer: CurrentTimer
    let start: () -> Void
    let stop: () -> Void
    let save: (String) -> Void
    @State private var label: String = ""
    private var timeComponent: TimeComponents {
        TimeConverter.convertFromSeconds(currentTimer.model.timer)
    }
    var body: some View {
        VStack(spacing: 10) {
            ProgressLabelDetailAnimation(
                progress: Double(currentTimer.timer.progress),
                secondsRemaining: currentTimer.timer.secondsRemaining
            )
            StartStopButtonView(
                start: { start() },
                stop: { stop() },
                isRunning: currentTimer.timer.isRunning
            )
            TimerNameView(name: $label)
        }
        .onAppear {
            label = currentTimer.model.name
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.background))
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Save") {
                    save(label)
                }
            }
        }
    }
}


