import SwiftUI

extension Binding where Value == String? {
    func unwrap(default defaultValue: String = "") -> Binding<String> {
        Binding<String>(
            get: {
                wrappedValue ?? defaultValue
            },
            set: {
                wrappedValue = $0.isEmpty ? nil : $0
            }
        )
    }
}
