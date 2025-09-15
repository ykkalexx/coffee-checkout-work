import Foundation
import Combine

@Observable class BasketViewModel {
    private(set) var basketItems: [BasketItem] = []
    private(set) var subtotal: Double = 0.0
    private(set) var total: Double = 0.0
    private(set) var totalQuantity: Int = 0
    
    let deliveryFee: Double = 5.00
    let headerText: String = "Basket"
    let emptyBasketText: String = "Your basket is empty"
    let summaryViewText: [String] = ["Subtotal", "Delivery", "Total"]
    let checkoutButtonText: String = "Proceed to checkout"
    
    private let repository: BasketRepository
    private let addCoffeeToBasket: AddCoffeeToBasketUseCase
    private let decreaseItemQuantity: DecreaseItemQuantityUseCase
    private let removeItemFromBasket: RemoveItemFromBasketUseCase
    private let emptyBasket: EmptyBasketUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    var subtotalFormatted: String {
        return formatAsCurrency(subtotal)
    }
    
    var deliveryFeeFormatted: String {
        return formatAsCurrency(deliveryFee)
    }
    
    var totalFormatted: String {
        return formatAsCurrency(total)
    }

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
    
    private func formatAsCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = fetchLocalCurrency()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "€0.00"
    }
}
