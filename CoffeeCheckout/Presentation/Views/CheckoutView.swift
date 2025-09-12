import SwiftUI
import PassKit

struct CheckoutView: View {
    @StateObject private var viewModel = CheckoutViewModel()

    var body: some View {
        VStack(spacing: 24) {
            Text(viewModel.title)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)

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

            Text(viewModel.alternativePaymentText)
                .foregroundColor(.gray)
                .font(.subheadline)
            
            PayWithApplePayButton(action: viewModel.handleApplePay)
                .cornerRadius(12)
                .frame(height: 60)
            
            Spacer()

            OrangeButton(action: {
                Task {
                    await viewModel.processPayment()
                }
            }) {
                Text(viewModel.continueButtonText)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.mainBg)
        .sheet(isPresented: $viewModel.showingBottomSheet) {
            
            BottomSheetPayment(
                imageName: "checkmark.circle.fill",
                title: "Payment Succesful!",
                message: "Your order has been placed successfully.",
                isSuccess: true
                
            )
                .presentationDetents([.height(200),])
        }
        .sheet(isPresented: $viewModel.showFailedPayment ) {
            BottomSheetPayment(
                imageName: "xmark.circle.fill",
                title: "Payment Failed!",
                message: "Something went wrong. Try again later.",
                isSuccess: false
            )
                .presentationDetents([.height(200),])
        }
    }
}

#Preview {
    NavigationView {
        CheckoutView()
    }
}
