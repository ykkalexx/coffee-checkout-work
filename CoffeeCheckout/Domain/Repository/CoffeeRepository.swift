import Foundation

protocol CoffeeRepository {
    func fetchAllCoffees() async throws -> [Coffee]
}
