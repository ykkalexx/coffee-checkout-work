import SwiftUI

@main
struct CoffeeCheckoutApp: App {
    private let basketRepository = InMemoryBasketRepository()
    private let coffeeRepository = MockCoffeeRepository()
    private let addCoffeeUseCase: AddCoffeeToBasketUseCase
    
    private let basketViewModel: BasketViewModel
    private let catalogViewModel: CatalogViewModel
    
    init() {
        self.addCoffeeUseCase = AddCoffeeToBasketUseCase(repository: basketRepository)
        self.basketViewModel = BasketViewModel(repository: basketRepository)
        self.catalogViewModel = CatalogViewModel(
            coffeeRepository: coffeeRepository,
            addCoffeeToBasketUseCase: addCoffeeUseCase
        )
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(
                catalogViewModel: catalogViewModel,
                basketViewModel: basketViewModel
            )
        }
    }
}

