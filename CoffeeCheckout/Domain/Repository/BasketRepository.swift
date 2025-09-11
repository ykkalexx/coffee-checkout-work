import Foundation
import Combine

protocol BasketRepository {
    var itemsPublisher: AnyPublisher<[BasketItem], Never> { get }
    
    func getItems() -> [BasketItem]
    func save(item: BasketItem)
    func delete(item: BasketItem)
    func clearBasket()
}

