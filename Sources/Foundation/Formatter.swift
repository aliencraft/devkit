import Foundation

//extension Formatter {
//    public static let currency: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.locale = .autoupdatingCurrent
//        formatter.numberStyle = .currency
//        formatter.currencyCode = "EUR"
//        formatter.multiplier = 0.01
//        formatter.minimumFractionDigits = 2
//        formatter.maximumFractionDigits = 2
//        return formatter
//    }()
//
//    public static let percent: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.locale = .autoupdatingCurrent
//        formatter.numberStyle = .percent
//        formatter.minimumFractionDigits = 0
//        formatter.maximumFractionDigits = 2
//        formatter.multiplier = 1
//        return formatter
//    }()
//
//    public static let number: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.locale = .autoupdatingCurrent
//        formatter.minimumFractionDigits = 0
//        formatter.maximumFractionDigits = 2
//        return formatter
//    }()
//}

extension Decimal {
    public func string(_ format: Format = .default, symbol: Bool = true, currency: String? = nil) -> String? {
        switch format {
        case .default:
            let formatter = NumberFormatter()
            formatter.locale = .autoupdatingCurrent
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            return formatter.string(for: self)

        case .currency:
            let formatter = NumberFormatter()
            formatter.locale = .autoupdatingCurrent
            let number = self / 100
            if number == number.rounded() {
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 0
            } else {
                formatter.minimumFractionDigits = 2
                formatter.maximumFractionDigits = 2
            }
            if symbol {
                formatter.numberStyle = .currency
                formatter.currencyCode = currency ?? "EUR"
                if currency == "PLN" {
                    formatter.locale = Locale(identifier: "pl")
                }
            }
            return formatter.string(for: number)

        case .percent:
            let formatter = NumberFormatter()
            formatter.locale = .autoupdatingCurrent
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            if symbol {
                formatter.numberStyle = .percent
                formatter.multiplier = 1
            }
            return formatter.string(for: self)
        }
    }

    public enum Format { case `default`, currency, percent }

    public func rounded(_ mode: NSDecimalNumber.RoundingMode = .down, scale: Int = 0) -> Decimal {
        var number = self
        var result = Decimal()
        NSDecimalRound(&result, &number, scale, mode)
        return result
    }
}

extension String {
    public func separated(by separator: String, every stride: Int) -> String {
        enumerated().map { $0 > 0 && $0.isMultiple(of: stride) ? "\(separator)\($1)" : "\($1)" }.joined()
    }
}
