//
//  MockPaymentRepository.swift
//  CoffeeCheckout
//
//  Created by Vlad Alex Barbatescu on 10/09/2025.
//

class MockPaymentRepository: PaymentRepository {
    func handlePayment() async throws -> Bool {
        return true
    }
}
