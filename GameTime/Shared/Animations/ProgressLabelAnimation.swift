import SwiftUI

struct ProgressLabelRowAnimation: View {
    let progress: Double
    let secondsRemaining: Int
    let play = "play.fill"
    let pause = "pause.fill"
    var isRunning: Bool
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray.opacity(0.2), lineWidth: 6)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(lineWidth: 6)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(Color.primaryAction)
                .animation(.linear(duration: 1), value: progress)
            Image(systemName: isRunning ? pause : play)
        }
        .frame(width: 48, height: 48)
    }
}
