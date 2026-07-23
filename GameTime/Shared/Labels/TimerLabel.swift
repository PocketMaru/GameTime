import SwiftUI

@ViewBuilder
func timerLabel(
    label: String,
    image: String,
    actionColor: Color,
    textColor: Color
) -> some View {
    Circle()
        .fill(actionColor).opacity(0.7)
        .frame(width: 60, height: 60)
        .overlay {
            Label(label, systemImage: image)
                .foregroundStyle(textColor).opacity(0.7)
        }
}
