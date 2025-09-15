import SwiftUI

enum Tab {
    case menu, basket, orders
}

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .menu
    
    let catalogViewModel: CatalogViewModel
    let basketViewModel: BasketViewModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            menuTabView
            basketTabView
        }
        .tint(.orange)
        .environment(catalogViewModel)
        .environment(basketViewModel)
        .onAppear(perform: setupTabBarAppearance)
    }
}

private extension MainTabView {
    var menuTabView: some View {
        CatalogView()
            .tabItem {
                Label("Menu", systemImage: "list.bullet")
            }
            .tag(Tab.menu)
    }

    var basketTabView: some View {
        NavigationStack {
            BasketView()
        }
        .tabItem {
            Label("Basket", systemImage: "basket.fill")
        }
        .tag(Tab.basket)
    }
    
    func setupTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "cardC")
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
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
    
    return MainTabView(
        catalogViewModel: catalogVM,
        basketViewModel: basketVM
    )
}
