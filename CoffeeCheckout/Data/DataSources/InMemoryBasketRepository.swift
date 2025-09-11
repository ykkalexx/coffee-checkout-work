import Foundation
import Combine

class InMemoryBasketRepository: BasketRepository {
    
    @Published private var basketItems: [BasketItem] = []
    
    var itemsPublisher: AnyPublisher<[BasketItem], Never> {
        $basketItems.eraseToAnyPublisher()
    }
    
    func getItems() -> [BasketItem] {
        return basketItems
    }
    
    func save(item: BasketItem) {
        if let index = basketItems.firstIndex(where: { $0.coffee.id == item.coffee.id }) {
            basketItems[index] = item
        } else {
            basketItems.append(item)
        }
    }
    
    func delete(item: BasketItem) {
        basketItems.removeAll { $0.coffee.id == item.coffee.id }
    }
    
    func clearBasket() {
        basketItems.removeAll()
    }
}
