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

            OrangeButton(action: viewModel.continueToNextStep) {
                Text(viewModel.continueButtonText)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.mainBg)
    }
}

#Preview {
    NavigationView {
        CheckoutView()
    }
}
