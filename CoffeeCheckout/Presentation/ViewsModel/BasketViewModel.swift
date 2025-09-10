import Foundation
import Combine

class BasketViewModel: ObservableObject {
    @Published var basketManager: BasketManagement
    @Published var basketItems: [BasketItem] = []
    
    init(basketManager : BasketManagement) {
        self.basketManager = basketManager
    }
    
    func isBasketEmpty() -> Bool {
        return basketItems.isEmpty
    }
    
    func fetchBasketItems() {
        basketItems.append(contentsOf: basketManager.basketItems)
    }
}
