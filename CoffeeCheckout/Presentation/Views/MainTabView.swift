import SwiftUI

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .menu
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CatalogView()
                .tabItem {
                    Label("Menu", systemImage: "list.bullet")
                }
                .tag(Tab.menu)
            
            BasketView()
                .tabItem {
                    Label("Basket", systemImage: "basket.fill")
                }
                .tag(Tab.basket)
            
            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: "clock.fill")
                }
                .tag(Tab.orders)
        }
        .tint(.miniText)
    }
}

#Preview {
    MainTabView()
}

