import SwiftUI

struct PresetButtonView: View {
    let value: TimeComponents
    let action: (TimeComponents) -> Void
    var title: String {
        if value.hours == 0 {
            title = "MIN"
        } else {
            title = "HR"
        }
    }
    var body: some View {
        Button {
            action(value)
        } label: {
            Circle()
                .fill(Color.primaryAction).opacity(0.7)
                .frame(width: 80, height: 80)
                .overlay {
                    VStack(spacing: 2) {
                        timeLabel(value)
                            .font(.title2)
                            .foregroundStyle(Color.primaryText)
                            .opacity(0.7)
                        Text(title)
                            .font(.title2)
                            .foregroundStyle(Color.secondaryAction)
                            .opacity(0.7)
                    }
                }
        }
    }
    @ViewBuilder
    private func timeLabel(_ value: TimeComponents) -> some View {
        if value.hours == 0 && value.seconds == 0 {
            Text("\(value.minutes)")
        }
        if value.minutes == 0 && value.seconds == 0 {
            Text("\(value.hours)")
        }
    }
}
