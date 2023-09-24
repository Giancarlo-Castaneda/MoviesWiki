import Foundation

public class RunTimeFormatter {

    private let formatter: DateComponentsFormatter

    public init(unitsStyle: DateComponentsFormatter.UnitsStyle) {
        formatter = DateComponentsFormatter()
        formatter.unitsStyle = unitsStyle
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.hour, .minute]
    }

    public convenience init(allowedUnit: NSCalendar.Unit, unitsStyle: DateComponentsFormatter.UnitsStyle) {
        self.init(unitsStyle: unitsStyle)
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = allowedUnit
    }

    func getRuntimeFormatted(value: Int) -> String {
        let runtime: TimeInterval = TimeInterval(value * 60)
        if let result = formatter.string(from: runtime) {
            return result
        }
        return ""
    }
}
