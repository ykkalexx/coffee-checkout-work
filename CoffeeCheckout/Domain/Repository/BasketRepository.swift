import Foundation

protocol BasketRepository: ObservableObject {
    var subtotal: Double { get }
    var deliveryFee: Double { get }
    var total: Double { get }
    
    func addCoffeeToBasket(_ item: Coffee) -> Void
    func removeItemFromBasket(_ item: Coffee) -> Void
    func fetchBasketItems() -> [BasketItem]
    func decreaseQuanityOfItem(_ item: Coffee) -> Void
    func fetchTotalQuanity() -> Int
}
