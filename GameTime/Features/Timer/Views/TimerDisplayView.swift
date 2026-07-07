import SwiftUI

struct TimerDisplayView: View {
    let name: String
    let seconds: Int
    var body: some View {
        Text(name)
            .font(.headline)
            .multilineTextAlignment(.center)
        timeDisplay(seconds: seconds)
    }
}

@ViewBuilder
private func timeDisplay(seconds: Int) -> some View {
    let converted = TimeConverter.convertFromSeconds(seconds)
    HStack {
        Text("\(converted.hours)")
        Text(":")
        Text("\(converted.minutes)")
        Text(":")
        Text("\(converted.seconds)")
    }
}
