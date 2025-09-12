import SwiftUI

struct BasketCard: View {
    let imageName: String
    let title: String
    let price: String
    let quantity: Int
    
    let onDecrement: () -> Void
    let onIncrement: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            
            VStack(alignment: .leading, spacing: 8) {
                titleView
                priceView
            }

            Spacer()

            quantityControlView
        }
        .padding()
    }
}


private extension BasketCard {
    
    var titleView: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
    
    var priceView: some View {
        Text(price)
            .font(.headline)
            .foregroundColor(.miniText)
    }
    
    var quantityControlView: some View {
        HStack(spacing: 15) {
            Button(action: onDecrement) {
                Image(systemName: "minus.circle.fill")
            }
            .disabled(quantity <= 0)

            Text("\(quantity)")
                .font(.title3)
                .fontWeight(.bold)
                .frame(minWidth: 25)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

            Button(action: onIncrement) {
                Image(systemName: "plus.circle.fill")
            }
        }
        .font(.title2)
        .foregroundColor(.orange)
    }
}
