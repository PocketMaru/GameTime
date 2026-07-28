import SwiftUI

struct PresetTimerRowView: View {
    let action: (TimeComponents) -> Void
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Section {
                HStack(spacing: 10) {
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 1, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 2, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 3, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 4, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 5, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 10, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 15, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 20, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 30, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 45, hours: 0),
                        title: "MIN",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 0, hours: 1),
                        title: "HR",
                        action: action
                    )
                    PresetButtonView(
                        value: TimeComponents(seconds: 0, minutes: 0, hours: 2),
                        title: "HR",
                        action: action
                    )
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
