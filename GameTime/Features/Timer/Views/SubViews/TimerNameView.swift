import SwiftUI

struct TimerNameView: View {
    @Binding var name: String
    var body: some View {
        VStack {
            TextField("Label", text: $name)
                .foregroundStyle(Color.mainText)
                .frame(width: 250)
                .bubbleStyle()
        }
    }
}
