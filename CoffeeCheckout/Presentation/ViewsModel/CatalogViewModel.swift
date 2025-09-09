import Foundation
import Combine

class CatalogViewModel: ObservableObject {
    @Published var coffees: [Coffee] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    private let repository: CoffeeRepository
    
    init(repository: CoffeeRepository = MockCoffeeRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func fetchCoffee() async {
        isLoading = true
        error = nil
        
        do {
            self.coffees = try await repository.fetchAllCoffees()
        } catch {
            self.error = "Failed to fetch coffees: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
}
