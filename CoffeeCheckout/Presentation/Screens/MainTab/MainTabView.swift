import SwiftUI

struct MainTabView: View {
    @State private var viewModel: MainTabViewModel
    init(viewModel: MainTabViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            menuTabView
            basketTabView
        }
        .tint(.orange)
        .environment(viewModel.catalogViewModel)
        .environment(viewModel.basketViewModel)
        .onAppear(perform: viewModel.setupTabBarAppearance)
    }
}

private extension MainTabView {
    var menuTabView: some View {
        CatalogView()
            .tabItem {
                Label("Menu", systemImage: "list.bullet")
            }
            .tag(MainTabViewModel.Tab.menu)
    }

    var basketTabView: some View {
        NavigationStack {
            BasketView()
        }
        .tabItem {
            Label("Basket", systemImage: "basket.fill")
        }
        .tag(MainTabViewModel.Tab.basket)
    }
}

#Preview {
    let basketRepository = InMemoryBasketRepository()
    let coffeeRepository = MockCoffeeRepository()
    let addCoffeeUseCase = AddCoffeeToBasketUseCase(repository: basketRepository)
    let basketVM = BasketViewModel(repository: basketRepository)
    let catalogVM = CatalogViewModel(
        coffeeRepository: coffeeRepository,
        addCoffeeToBasketUseCase: addCoffeeUseCase
    )
    let mainTabVM = MainTabViewModel(
        catalogViewModel: catalogVM,
        basketViewModel: basketVM
    )
    return MainTabView(viewModel: mainTabVM)
}
