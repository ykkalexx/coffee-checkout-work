protocol PaymentRepository {
    func handlePayment() async throws -> Bool
}
