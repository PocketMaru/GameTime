import SwiftUI

extension Binding where Value == Double? {
    func unwrap(default defaultValue: Double = 0) -> Binding<Double> {
        Binding<Double>(
            get: {
                wrappedValue ?? defaultValue
            },
            set: {
                wrappedValue = $0 == 0 ? nil : $0
            }
        )
    }
}
