/**

import Foundation

class BasketManagement: BasketRepository, ObservableObject {
    @Published public var basketItems: [BasketItem] = []
    
    public var subtotal: Double {
        return basketItems.reduce(0) { total, item in
            total + (item.coffee.price * Double(item.quantity))
        }
    }

    public let deliveryFee: Double = 5.00

    public var total: Double {
        return subtotal + deliveryFee
    }

    func addCoffeeToBasket(_ item: Coffee) {
        if let index = basketItems.firstIndex(where: { $0.coffee.id == item.id }) {
            basketItems[index].quantity += 1
        } else {
            let newBasketItem = BasketItem(id: UUID().uuidString, coffee: item, quantity: 1)
            basketItems.append(newBasketItem)
        }
    }

    func removeItemFromBasket(_ item: Coffee) {
        if let index = basketItems.firstIndex(where: { $0.coffee.id == item.id }) {
            basketItems.remove(at: index)
        }
    }
    
    func fetchBasketItems() -> [BasketItem] {
        return basketItems
    }

    func decreaseQuanityOfItem(_ item: Coffee) {
        if let index = basketItems.firstIndex(where: { $0.coffee.id == item.id }) {
            if basketItems[index].quantity > 1 {
                basketItems[index].quantity -= 1
            } else {
                basketItems.remove(at: index)
            }
        }
    }

    func fetchTotalQuanity() -> Int {
        return basketItems.reduce(0) { $0 + $1.quantity }
    }
    
    func emptyBasket() -> Void {
        basketItems.removeAll()
    }
}

*/
