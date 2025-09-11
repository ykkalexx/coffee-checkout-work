import Foundation

struct EmptyBasketUseCase {
    private let repository: BasketRepository
    
    init(repository: BasketRepository) {
        self.repository = repository
    }
    
    func callAsFunction() {
        repository.clearBasket()
    }
}
