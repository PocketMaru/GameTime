import SwiftUI

@ViewBuilder
func timerButton(
    label: String,
    actionColor: Color,
    textColor: Color
) -> some View {
    Circle()
        .fill(actionColor).opacity(0.7)
        .frame(width: 60, height: 60)
        .overlay {
            Text(label)
                .foregroundStyle(textColor).opacity(0.7)
        }
}
