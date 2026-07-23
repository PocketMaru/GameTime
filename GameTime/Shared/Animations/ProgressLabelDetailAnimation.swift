import SwiftUI

struct ProgressLabelDetailAnimation: View {
    let progress: Double
    let secondsRemaining: Int
    
    private var converted: TimeComponents {
        return TimeConverter.convertFromSeconds(secondsRemaining)
    }
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
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    Text("\(converted.hours)")
                    Text(":")
                    Text(TimeConverter.timeFormatter(converted.minutes))
                    Text(":")
                    Text(TimeConverter.timeFormatter(converted.seconds))
                }
                .monospacedDigit()
                .font(Font.largeTitle.weight(.bold))
            }
        }
        .frame(width: 220, height: 220)
    }
}
