protocol FetchCoffeeUseCase {
    func execute() async throws -> [Coffee]
}

class DefaultFetchCoffeeUseCase: FetchCoffeeUseCase {
    private let coffeeRepository: CoffeeRepository
    
    init(coffeeRepository: CoffeeRepository) {
        self.coffeeRepository = coffeeRepository
    }
    
    func execute() async throws -> [Coffee] {
        return try await coffeeRepository.fetchAllCoffees()
    }
}
