import SwiftUI
import Combine

class CheckoutViewModel: ObservableObject {
    @Published var paymentMethods: [PaymentMethod] = []
    @Published var selectedPaymentMethodId: String?
    
    let title = "Select Payment Method"
    let alternativePaymentText = "Or Pay Using"
    let continueButtonText = "Continue"

    init() {
        loadPaymentMethods()
        selectedPaymentMethodId = paymentMethods.first?.id
    }
    
    func selectPaymentMethod(id: String) {
        selectedPaymentMethodId = id
    }
    
    func handleApplePay() {
        print("Apple Pay button tapped. Initiating payment...")
    }
    
    func continueToNextStep() {
        guard let selectedId = selectedPaymentMethodId else {
            print("Error: No payment method is selected.")
            return
        }
        print("Continuing checkout with payment method: \(selectedId)")
    }
        
    private func loadPaymentMethods() {
        paymentMethods = [
            PaymentMethod(id: "debit", name: "Debit Card", imageName: "creditcard.fill"),
            PaymentMethod(id: "paypal", name: "PayPal", imageName: "dollarsign.circle.fill")
        ]
    }
}
