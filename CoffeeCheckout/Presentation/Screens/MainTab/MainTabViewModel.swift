import Foundation
import SwiftUI

@Observable
class MainTabViewModel {
    var selectedTab: Tab = .menu
    let catalogViewModel: CatalogViewModel
    let basketViewModel: BasketViewModel
    
    enum Tab {
        case menu, basket
    }

    init(catalogViewModel: CatalogViewModel, basketViewModel: BasketViewModel) {
        self.catalogViewModel = catalogViewModel
        self.basketViewModel = basketViewModel
    }
    
    func setupTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(named: "cardC")
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

}
