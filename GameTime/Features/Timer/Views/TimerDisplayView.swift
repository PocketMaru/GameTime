import SwiftUI

struct TimerDisplayView: View {
    let name: String
    let seconds: Int
    var body: some View {
        VStack(alignment: .leading) {
            timeDisplay(seconds: seconds)
                .font(Font.largeTitle.weight(.bold))
            Text(name)
        }
    }
}

@ViewBuilder
private func timeDisplay(seconds: Int) -> some View {
    let converted = TimeConverter.convertFromSeconds(seconds)
    HStack {
        Text("\(converted.hours)")
        Text(":")
        Text(formatStringDouble(converted.minutes))
        Text(":")
        Text(formatStringDouble(converted.seconds))
    }
}

private func formatStringDouble(_ integer: Int) -> String {
    Double(integer).formatted(.number.precision(.fractionLength(4)))
}
