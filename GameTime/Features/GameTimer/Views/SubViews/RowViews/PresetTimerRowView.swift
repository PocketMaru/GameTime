import SwiftUI

struct PresetTimerRowView: View {
    let presets: [TimeComponents] = [
        .init(minutes: 1),
        .init(minutes: 2),
        .init(minutes: 3),
        .init(minutes: 4),
        .init(minutes: 5),
        .init(minutes: 10),
        .init(minutes: 15),
        .init(minutes: 20),
        .init(minutes: 30),
        .init(minutes: 45),
        .init(hours: 1),
        .init(hours: 2)
    ]
    let action: (TimeComponents) -> Void
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Section {
                HStack(spacing: 10) {
                    ForEach(presets, id: \.compare) { timer in
                        PresetButtonView(
                            value: timer,
                            action: action
                        )
                    }
                }
            } header: {
                Text("Presets")
                    .foregroundStyle(Color.primaryText)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
        }
    }
}

private extension TimeComponents {
    var compare: String {
        "\(hours):\(minutes):\(seconds)"
    }
}
