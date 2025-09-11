import Foundation
import Combine

class BasketViewModel: ObservableObject {
    @Published private(set) var basketItems: [BasketItem] = []
    @Published private(set) var subtotal: Double = 0.0
    @Published private(set) var total: Double = 0.0
    @Published private(set) var totalQuantity: Int = 0
    
    let deliveryFee: Double = 5.00
    
    private let repository: BasketRepository
    private let addCoffeeToBasket: AddCoffeeToBasketUseCase
    private let decreaseItemQuantity: DecreaseItemQuantityUseCase
    private let removeItemFromBasket: RemoveItemFromBasketUseCase
    private let emptyBasket: EmptyBasketUseCase
    
    private var cancellables = Set<AnyCancellable>()

    init(repository: BasketRepository) {
        self.repository = repository
        self.addCoffeeToBasket = AddCoffeeToBasketUseCase(repository: repository)
        self.decreaseItemQuantity = DecreaseItemQuantityUseCase(repository: repository)
        self.removeItemFromBasket = RemoveItemFromBasketUseCase(repository: repository)
        self.emptyBasket = EmptyBasketUseCase(repository: repository)
        
        setupSubscribers()
    }
    
    func add(coffee: Coffee) {
        addCoffeeToBasket(coffee)
    }
    
    func decreaseQuantity(for coffee: Coffee) {
        decreaseItemQuantity(coffee)
    }
    
    func remove(coffee: Coffee) {
        removeItemFromBasket(coffee)
    }
    
    func clear() {
        emptyBasket()
    }
    
    private func setupSubscribers() {
        repository.itemsPublisher
            .sink { [weak self] items in
                guard let self = self else { return }
                
                self.basketItems = items
                
                self.recalculateTotals(items: items)
            }
            .store(in: &cancellables)
    }
    
    private func recalculateTotals(items: [BasketItem]) {
        self.subtotal = items.reduce(0) { $0 + ($1.coffee.price * Double($1.quantity)) }
        self.total = self.subtotal + self.deliveryFee
        self.totalQuantity = items.reduce(0) { $0 + $1.quantity }
    }
}
