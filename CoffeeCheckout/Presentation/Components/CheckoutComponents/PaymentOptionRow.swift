import SwiftUI

struct PaymentOptionRow: View {
    let method: PaymentMethod
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            iconView
            nameView
            Spacer()
            selectionIndicatorView
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.cardC)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(strokeColor, lineWidth: 1.5)
        )
        .animation(.spring(), value: isSelected)
    }
}

private extension PaymentOptionRow {
    var iconView: some View {
        Image(systemName: method.imageName)
            .font(.title2)
            .frame(width: 40)
            .foregroundColor(isSelected ? .orange : .secondary)
    }

    var nameView: some View {
        Text(method.name)
            .fontWeight(.medium)
            .foregroundColor(.primary)
    }

    var selectionIndicatorView: some View {
        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
            .font(.title2)
            .foregroundColor(isSelected ? .orange : .secondary)
    }
    
    var strokeColor: Color {
        isSelected ? .orange : .miniText
    }
}
