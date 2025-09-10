protocol FetchPaymentRespUseCase {
    func execute() async throws -> Bool
}

class DefaulyPaymentRespUseCase: FetchPaymentRespUseCase {
    private let paymentRepository: PaymentRepository
    
    init(paymentRepository: PaymentRepository) {
        self.paymentRepository = paymentRepository
    }
    
    func execute() async throws -> Bool {
        return try await paymentRepository.handlePayment()
    }
}
