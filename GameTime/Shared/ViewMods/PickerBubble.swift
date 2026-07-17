import SwiftUI

@ViewBuilder
func pickerBubble() -> some View {
    RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(Color(.white).opacity(0.6))
        .frame(height: 32)
        .padding(.bottom, 63)
}

