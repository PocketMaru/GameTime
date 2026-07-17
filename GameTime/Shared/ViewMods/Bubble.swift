import SwiftUI

struct BubbleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
            .frame(height: 52)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color(.systemGray4), lineWidth: 0.5)
                    }
                    .shadow(
                        color: .black.opacity(0.06),
                        radius: 2,
                        x: 0,
                        y: 1
                    )
            }
    }
}

extension View {
    func bubbleStyle() -> some View {
        modifier(BubbleStyle())
    }
}
