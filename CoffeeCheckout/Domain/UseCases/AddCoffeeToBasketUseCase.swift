import Foundation


struct AddCoffeeToBasketUseCase {
    private let repository: BasketRepository

    init(repository: BasketRepository) {
        self.repository = repository
    }

    func callAsFunction(_ coffee: Coffee) {
        let currentItems = repository.getItems()
        
        if var existingItem = currentItems.first(where: { $0.coffee.id == coffee.id }) {
            existingItem.quantity += 1
            repository.save(item: existingItem)
        } else {
            let newItem = BasketItem(id: UUID().uuidString, coffee: coffee, quantity: 1)
            repository.save(item: newItem)
        }
    }
}
