import SwiftUI

struct GameTimerDetailView: View {
    var currentTimer: CurrentTimer
    let start: () -> Void
    let stop: () -> Void
    @State private var label: String
    private var timeComponent: TimeComponents {
        TimeConverter.convertFromSeconds(currentTimer.model.timer)
    }
    
    init(currentTimer: CurrentTimer) {
        self.currentTimer = currentTimer
        _label = State(initialValue: currentTimer.model.name)
        self.start = { currentTimer.timer.start() }
        self.stop = { currentTimer.timer.cancel() }
    }
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack(spacing: 10) {
                ProgressLabelDetailAnimation(
                    progress: Double(currentTimer.timer.progress),
                    secondsRemaining: currentTimer.timer.secondsRemaining
                )
                StartStopButtonView(
                    start: { start() },
                    stop: { stop() }
                )
                TimerNameView(name: $label)
            }
        }
        
    }
}


