import SwiftUI

struct QuantityButton: View {
    @Binding var quantity: Int
    
    var body: some View {
        HStack(spacing: 8) {
            Button(action: {
                if quantity > 1 {
                    quantity -= 1
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.orange)
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            
            Text("\(quantity)")
                .font(.body)
                .fontWeight(.bold)
                .padding(.horizontal, 4)
                .foregroundStyle(.white)
            
            Button(action: {
                quantity += 1
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.orange)
                    .font(.title2)
                    .foregroundStyle(.white)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(20)
    }
}
