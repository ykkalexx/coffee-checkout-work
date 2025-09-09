protocol FetchCoffeeUseCase {
    func execute() async throws -> [Coffee]
}
