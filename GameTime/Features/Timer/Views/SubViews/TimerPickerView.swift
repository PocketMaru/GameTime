import SwiftUI

struct TimerPickerView: View {
    @Binding var selectedSeconds: Int
    @Binding var selectedMinutes: Int
    @Binding var selectedHours: Int

    var body: some View {
        HStack {
            VStack {
                Text("Hours")
                    .font(.footnote)
                Picker("Hours", selection: $selectedHours) {
                    ForEach(0...24, id: \.self) { hour in
                        Text("\(hour)")
                            .tag(hour)
                    }
                }
                .pickerStyle(.wheel)
            }
            Text(":")
            VStack {
                Text("Minutes")
                    .font(.footnote)
                Picker("Minute", selection: $selectedMinutes) {
                    ForEach(0...60, id: \.self) { minute in
                        Text("\(minute)")
                            .tag(minute)
                    }
                }
                .pickerStyle(.wheel)
            }
            Text(":")
            VStack {
                Text("Seconds")
                Picker("Second", selection: $selectedSeconds) {
                    ForEach(0...60, id: \.self) { second in
                        Text("\(second)")
                            .tag(second)
                    }
                }
                .pickerStyle(.wheel)
            }
        }
    }
}
