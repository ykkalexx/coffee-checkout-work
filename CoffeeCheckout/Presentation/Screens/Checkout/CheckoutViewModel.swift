import SwiftUI
import Combine

enum SheetType: Identifiable {
    case paymentSuccess
    case paymentFailed

    var id: Self { self }
}

@Observable class CheckoutViewModel {
    var paymentMethods: [PaymentMethod] = []
    var selectedPaymentMethodId: String?
    private let paymentRepository: PaymentRepository
    var activeSheet: SheetType?

    let title = "Select Payment Method"
    let alternativePaymentText = "Or Pay Using"
    let continueButtonText = "Continue"

    init(paymentRepository: PaymentRepository = MockPaymentRepository()) {
        self.paymentRepository = paymentRepository
        loadPaymentMethods()
        selectedPaymentMethodId = paymentMethods.first?.id
    }
    
    func selectPaymentMethod(id: String) {
        selectedPaymentMethodId = id
    }
    
    func handleApplePay() {
        print("Apple Pay button tapped. Initiating payment...")
    }
    
    func processPayment() async {
        guard selectedPaymentMethodId != nil else {
            print("Error: No payment method is selected.")
            return
        }
        
        do {
            let success = try await paymentRepository.handlePayment()
            
            await MainActor.run {
                if success {
                    self.activeSheet = .paymentSuccess
                } else {
                    print("Payment failed.")
                    self.activeSheet = .paymentFailed
                }
            }
        } catch {
            print("Failed to process payment: \(error.localizedDescription)")
            await MainActor.run {
                self.activeSheet = .paymentFailed
            }
        }
    }
    
    private func loadPaymentMethods() {
        paymentMethods = [
            PaymentMethod(id: "debit", name: "Debit Card", imageName: "creditcard.fill"),
            PaymentMethod(id: "paypal", name: "PayPal", imageName: "dollarsign.circle.fill")
        ]
    }
}
