import SwiftUI

struct PresetButtonView: View {
    let value: TimeComponents
    let title: String
    let action: (TimeComponents) -> Void
    var body: some View {
        Button {
            action(value)
        } label: {
            Circle()
                .fill(Color.primaryAction).opacity(0.7)
                .frame(width: 80, height: 80)
                .overlay {
                    VStack(spacing: 5) {
                        timeLabel(value)
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundStyle(Color.primaryText)
                            .opacity(0.7)
                        Text(title)
                            .font(.system(size: 20, weight: .bold))
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
