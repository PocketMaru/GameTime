import SwiftUI

struct GameTimeFormView: View {
    @Bindable var form: GameTimerFormVM
    var body: some View {
        VStack(spacing: 10) {
            TextField("Name", text: $form.name.unwrap())
                .font(.headline)
                .multilineTextAlignment(.center)
            TextField("Time", text: $form.timer.unwrap())
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    form.submit()
                }
            }
        }
    }
}
