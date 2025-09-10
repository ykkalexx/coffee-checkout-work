import SwiftUI
import Combine

class CheckoutViewModel: ObservableObject {
    @Published var paymentMethods: [PaymentMethod] = []
    @Published var selectedPaymentMethodId: String?
    @Published var showingBottomSheet: Bool = false
    
    @Published var isPaymentSuccessful: Bool = false
    private let paymentRepository: PaymentRepository
    
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
        guard let selectedId = selectedPaymentMethodId else {
            print("Error: No payment method is selected.")
            return
        }
        
        do {
            let success = try await paymentRepository.handlePayment()
            
            await MainActor.run {
                self.isPaymentSuccessful = success
                
                if success {
                    self.continueToNextStep()
                } else {
                    print("Payment failed.")
                }
            }
        } catch {
            print("Failed to process payment: \(error.localizedDescription)")
            await MainActor.run {
                self.isPaymentSuccessful = false
            }
        }
    }
    
    
    func continueToNextStep() {
        showingBottomSheet = true
    }
          
    private func loadPaymentMethods() {
        paymentMethods = [
            PaymentMethod(id: "debit", name: "Debit Card", imageName: "creditcard.fill"),
            PaymentMethod(id: "paypal", name: "PayPal", imageName: "dollarsign.circle.fill")
        ]
    }
}
