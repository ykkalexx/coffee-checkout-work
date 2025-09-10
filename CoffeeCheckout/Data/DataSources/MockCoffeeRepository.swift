import Foundation

class MockCoffeeRepository: CoffeeRepository {
    func fetchAllCoffees() async throws -> [Coffee] {
        return [
            Coffee(id: 1, name: "Vanilla Latte", desc: "A classic coffee drink", price: 4.50),
            Coffee(id: 2, name: "Caramel Macchiato", desc: "A sweet and indulgent treat", price: 4.50),
            Coffee(id: 3, name: "Mocha", desc: "A coffee drink with a rich and chocolatey", price: 4.50),
            Coffee(id: 4, name: "Cappuccino", desc: "An Italian coffee drink that consists of espresso", price: 4.50),
            Coffee(id: 5, name: "Americano", desc: "Espresso diluted with hot water", price: 4.50),
        ]
    }
}
