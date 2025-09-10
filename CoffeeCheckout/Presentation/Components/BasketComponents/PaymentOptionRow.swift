import SwiftUI

struct PaymentOptionRow: View {
    let method: PaymentMethod
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: method.imageName)
                .font(.title2)
                .frame(width: 40)
                .foregroundColor(isSelected ? .orange : Color.miniText)

            Text(method.name)
                .fontWeight(.medium)
                .foregroundColor(.white)

            Spacer()

            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundColor(isSelected ? .orange : Color(.white))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.cardC)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(isSelected ? Color.orange : Color(Color.miniText), lineWidth: 1.5)
        )
        .animation(.spring(), value: isSelected)
    }
}
