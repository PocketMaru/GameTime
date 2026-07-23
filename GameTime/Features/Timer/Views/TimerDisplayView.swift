import SwiftUI

struct TimerDisplayView: View {
    let secondsRemaining: Int
    let name: String
    private var converted: TimeComponents {
        TimeConverter.convertFromSeconds(secondsRemaining)
    }
    var body: some View {
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
            Text(name)
        }
    }
}
