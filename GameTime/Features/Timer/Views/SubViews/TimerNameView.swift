import SwiftUI

struct TimerNameView: View {
    @Binding var name: String
    var body: some View {
        TextField("Label", text: $name)
            .foregroundStyle(Color.primaryText)
            .frame(width: 250)
            .textFieldStyle()
    }
}
