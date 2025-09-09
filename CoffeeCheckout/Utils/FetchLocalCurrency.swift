import Foundation

func fetchLocalCurrency() -> String {
    let userLocale = Locale.current;
    let currencyCode = userLocale.currency?.identifier;
    
    switch currencyCode {
    case "USD":
        return "$"
    case "EUR":
        return "€"
    case "JPY":
        return "¥"
    case "GBP":
        return "£"
    default:
        return "Please work"
    }
}
