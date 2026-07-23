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
                if converted.hours > 0 {
                    Text("\(converted.hours)")
                    Text(":")
                    Text(TimeConverter.timeFormatter(converted.minutes))
                    Text(":")
                    Text(TimeConverter.timeFormatter(converted.seconds))
                } else if converted.hours == 0 {
                    Text(TimeConverter.timeFormatter(converted.minutes))
                    Text(":")
                    Text(TimeConverter.timeFormatter(converted.seconds))
                } else if converted.hours == 0 && converted.minutes == 0 {
                    Text(TimeConverter.timeFormatter(converted.seconds))
                }
                
            }
            .monospacedDigit()
            .foregroundStyle(Color.primaryText)
            .font(Font.largeTitle.weight(.bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            Text(name)
                .foregroundStyle(Color.primaryText)
        }
    }
}
