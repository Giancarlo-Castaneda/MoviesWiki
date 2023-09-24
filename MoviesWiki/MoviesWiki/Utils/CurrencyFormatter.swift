import Foundation

public class CurrencyFormatter {

    private let defaultDoubleDecimalSeparator: Character = "."

    public let numberFormatter: NumberFormatter

    public init(currencyCode: String) {
        self.numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = currencyCode
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = .current
        numberFormatter.maximumFractionDigits = 2
    }

    public convenience init(currencyCode: String, locale: Locale) {
        self.init(currencyCode: currencyCode)
        numberFormatter.locale = locale
    }

    func getFormattedCurrency(value: Int) -> String {

        let number = NSNumber(value: value)
        if let result = numberFormatter.string(from: number) {
            return result
        }
        return ""
    }
}
