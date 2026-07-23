import Foundation
import SwiftUI

struct TimeConverter {
    static func convertFromSeconds(_ seconds: Int) -> TimeComponents {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        
        return TimeComponents(seconds: seconds, minutes: minutes, hours: hours)
    }
    
    static func convertToSeconds(
        time: TimeComponents
    ) -> Int {
        (time.hours * 3600) + (time.minutes * 60) + time.seconds
    }
    
    static func toLabel(_ time: TimeComponents) -> String {
        if time.hours == 0 && time.minutes == 0 {
            return "\(time.seconds) sec"
        }
        if time.hours == 0 && time.seconds == 0 {
            return "\(time.minutes) min"
        }
        if time.hours == 0 {
            return "\(time.minutes) min, \(time.seconds) sec"
        }
        if time.minutes == 0 && time.seconds == 0 {
            return "\(time.hours) hr"
        }
        return "\(time.hours) hr, \(time.minutes) min, \(time.seconds) sec"
    }
    
    static func timeFormatter(_ value: Int) -> String {
        String(format: "%02d", value)
    }
}



