import SwiftUI

@main
struct CoffeeCheckoutApp: App {
    private let basketRepository = InMemoryBasketRepository()
    private let coffeeRepository = MockCoffeeRepository()
    private let addCoffeeUseCase: AddCoffeeToBasketUseCase
    private let basketViewModel: BasketViewModel
    private let catalogViewModel: CatalogViewModel
    private let mainTabViewModel: MainTabViewModel
    
    init() {
        self.addCoffeeUseCase = AddCoffeeToBasketUseCase(repository: basketRepository)
        self.basketViewModel = BasketViewModel(repository: basketRepository)
        self.catalogViewModel = CatalogViewModel(
            coffeeRepository: coffeeRepository,
            addCoffeeToBasketUseCase: addCoffeeUseCase
        )
        self.mainTabViewModel = MainTabViewModel(
            catalogViewModel: self.catalogViewModel,
            basketViewModel: self.basketViewModel
        )
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(viewModel: mainTabViewModel)
        }
    }
}
