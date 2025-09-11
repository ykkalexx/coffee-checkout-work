import Foundation

struct DecreaseItemQuantityUseCase {
    private let repository: BasketRepository

    init(repository: BasketRepository) {
        self.repository = repository
    }

    func callAsFunction(_ coffee: Coffee) {
        let currentItems = repository.getItems()
        
        guard var itemToDecrease = currentItems.first(where: { $0.coffee.id == coffee.id }) else {
            return
        }

        if itemToDecrease.quantity > 1 {
            itemToDecrease.quantity -= 1
            repository.save(item: itemToDecrease)
        } else {
            // If quantity is 1, decreasing it means removing the item.
            repository.delete(item: itemToDecrease)
        }
    }
}
