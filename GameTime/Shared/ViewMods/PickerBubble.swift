import SwiftUI

@ViewBuilder
func pickerBubble() -> some View {
    RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(Color.textField.opacity(0.8))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.white.opacity(0.08), lineWidth: 0.5)
        }
        .frame(height: 36)
        .padding(.bottom, 0.2)
}
