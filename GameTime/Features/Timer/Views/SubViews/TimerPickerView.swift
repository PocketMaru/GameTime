import SwiftUI

struct TimerPickerView: View {
    @Binding var selectedSeconds: Int
    @Binding var selectedMinutes: Int
    @Binding var selectedHours: Int
    @Binding var name: String
    var body: some View {
        ZStack {
                pickerBubble()
            VStack {
                HStack {
                    Picker("Hours", selection: $selectedHours) {
                        ForEach(0...24, id: \.self) { hour in
                            Text("\(hour)")
                                .foregroundStyle(Color.mainText)
                                .tag(hour)
                        }
                    }
                    ZStack(alignment: .leading) {
                        Text("hours")
                            .frame(alignment: .leading)
                            .opacity(selectedHours != 1 ? 1 : 0)
                            .foregroundStyle(Color.mainText)
                        Text("hour")
                            .frame(alignment: .leading)
                            .opacity(selectedHours == 1 ? 1 : 0)
                            .foregroundStyle(Color.mainText)
                    }
                    Picker("Minute", selection: $selectedMinutes) {
                        ForEach(0...59, id: \.self) { minute in
                            Text("\(minute)")
                                .foregroundStyle(Color.mainText)
                                .tag(minute)
                        }
                    }
                    Text("min")
                        .foregroundStyle(Color.mainText)
                    Picker("Second", selection: $selectedSeconds) {
                        ForEach(0...59, id: \.self) { second in
                            Text("\(second)")
                                .foregroundStyle(Color.mainText)
                                .tag(second)
                        }
                    }
                    Text("sec")
                        .foregroundStyle(Color.mainText)
                }
                .pickerStyle(.wheel)
                .labelsHidden()
                .padding(.horizontal, 12)
                TimerNameView(name: $name)
            }
            
        }
    }
}
// this is used to create hour and hours based on need
// ^[\(hour) hour](inflect: true)
