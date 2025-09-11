import Foundation

struct RemoveItemFromBasketUseCase {
    private let repository: BasketRepository
    
    init(repository: BasketRepository) {
        self.repository = repository
    }
    
    func callAsFunction(_ coffee: Coffee) {
        let currentItems = repository.getItems()
        
        if let itemToRemove = currentItems.first(where: { $0.coffee.id == coffee.id }) {
            repository.delete(item: itemToRemove)
        }
    }
}
