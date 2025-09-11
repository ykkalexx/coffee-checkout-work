import SwiftUI

enum Tab {
    case menu, basket, orders
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .menu
    @StateObject private var catalogViewModel: CatalogViewModel
    @StateObject private var basketViewModel: BasketViewModel
    
    init() {
        let basketRepository = InMemoryBasketRepository()
        let coffeeRepository = MockCoffeeRepository()
        let addCoffeeUseCase = AddCoffeeToBasketUseCase(repository: basketRepository)
        let basketVM = BasketViewModel(repository: basketRepository)
        let catalogVM = CatalogViewModel(
            coffeeRepository: coffeeRepository,
            addCoffeeToBasketUseCase: addCoffeeUseCase
        )
        
        _basketViewModel = StateObject(wrappedValue: basketVM)
        _catalogViewModel = StateObject(wrappedValue: catalogVM)
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.cardC
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CatalogView()
                .tabItem {
                    Label("Menu", systemImage: "list.bullet")
                }
                .tag(Tab.menu)
    
            NavigationStack {
                BasketView(viewModel: basketViewModel)
            }
            .tabItem {
                Label("Basket", systemImage: "basket.fill")
            }
            .tag(Tab.basket)
            
            Text("Orders")
                .tabItem {
                    Label("Orders", systemImage: "clock.fill")
                }
                .tag(Tab.orders)
        }
        .tint(.orange)
        .environmentObject(catalogViewModel)
        .environmentObject(basketViewModel)
    }
}

#Preview {
    MainTabView()
}

