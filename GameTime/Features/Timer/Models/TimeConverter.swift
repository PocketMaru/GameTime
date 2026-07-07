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
}
