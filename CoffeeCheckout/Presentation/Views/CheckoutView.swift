import SwiftUI
import PassKit

struct CheckoutView: View {
    @State private var viewModel = CheckoutViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            headerView
            paymentOptionsListView
            alternativePaymentsView
            Spacer()
            continueButton
        }
        .padding()
        .background(Color.mainBg.ignoresSafeArea())
        .sheet(item: $viewModel.activeSheet) { sheetType in
            paymentResultSheet(for: sheetType)
        }
    }
}

private extension CheckoutView {
    var headerView: some View {
        Text(viewModel.title)
            .font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
    }
    
    var paymentOptionsListView: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.paymentMethods) { method in
                PaymentOptionRow(
                    method: method,
                    isSelected: viewModel.selectedPaymentMethodId == method.id
                )
                .onTapGesture {
                    viewModel.selectPaymentMethod(id: method.id)
                }
            }
        }
    }
    
    var alternativePaymentsView: some View {
        VStack(spacing: 16) {
            Text(viewModel.alternativePaymentText)
                .foregroundColor(.gray)
                .font(.subheadline)
            
            PayWithApplePayButton(action: viewModel.handleApplePay)
                .cornerRadius(12)
                .frame(height: 60)
        }
    }
    
    var continueButton: some View {
        Button(action: {
            Task { await viewModel.processPayment() }
        }) {
            Text(viewModel.continueButtonText)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(OrangeButtonStyle())
    }
    
    @ViewBuilder
    func paymentResultSheet(for sheetType: SheetType) -> some View {
        switch sheetType {
        case .paymentSuccess:
            BottomSheetPayment(
                imageName: "checkmark.circle.fill",
                title: "Payment Successful!",
                message: "Your order has been placed successfully.",
                isSuccess: true
            )
            .presentationDetents([.height(200)])
            
        case .paymentFailed:
            BottomSheetPayment(
                imageName: "xmark.circle.fill",
                title: "Payment Failed!",
                message: "Something went wrong. Try again later.",
                isSuccess: false
            )
            .presentationDetents([.height(200)])
        }
    }
}

#Preview {
    NavigationView {
        CheckoutView()
    }
    .preferredColorScheme(.dark)
}
