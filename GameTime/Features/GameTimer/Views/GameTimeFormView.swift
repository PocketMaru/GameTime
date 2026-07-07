import SwiftUI

struct GameTimeFormView: View {
    @Bindable var form: GameTimerFormVM
    var body: some View {
        VStack(spacing: 10) {
            TextField("Name", text: $form.name.unwrap())
                .font(.headline)
                .multilineTextAlignment(.center)
            TimerPickerView(
                selectedSeconds: $form.timeComponents.seconds,
                selectedMinutes: $form.timeComponents.minutes,
                selectedHours: $form.timeComponents.hours,
            )
            .onChange(of: form.timeComponents.hours) { _, newValue in
                print("Hours:", newValue)
            }
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
