import SwiftUI

struct GameTimerDetailView: View {
    var currentTimer: CurrentTimer
    let start: () -> Void
    let stop: () -> Void
    let save: (String) -> Void
    @State private var label: String
    private var timeComponent: TimeComponents {
        TimeConverter.convertFromSeconds(currentTimer.model.timer)
    }
    
    init(
        currentTimer: CurrentTimer,
        start: @escaping () -> Void,
        stop: @escaping () -> Void,
        save: @escaping (String) -> Void,
    ) {
        self.currentTimer = currentTimer
        _label = State(initialValue: currentTimer.model.name)
        self.start = start
        self.stop = stop
        self.save = save
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
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Save") {
                    save(label)
                }
            }
        }
    }
    
}


