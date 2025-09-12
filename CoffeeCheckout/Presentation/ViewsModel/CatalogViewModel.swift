import Foundation
import Combine

@Observable class CatalogViewModel {
    var coffees: [Coffee] = []
    var isLoading: Bool = false
    var error: String?
    
    private let coffeeRepository: CoffeeRepository
    private let addCoffeeToBasket: AddCoffeeToBasketUseCase
    
    init(
        coffeeRepository: CoffeeRepository,
        addCoffeeToBasketUseCase: AddCoffeeToBasketUseCase
    ) {
        self.coffeeRepository = coffeeRepository
        self.addCoffeeToBasket = addCoffeeToBasketUseCase
    }
    
    func addToBasket(coffee: Coffee) {
        addCoffeeToBasket(coffee)
    }
    
    @MainActor
    func fetchCoffee() async {
        isLoading = true
        error = nil
        
        do {
            self.coffees = try await coffeeRepository.fetchAllCoffees()
        } catch {
            self.error = "Failed to fetch coffees: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
