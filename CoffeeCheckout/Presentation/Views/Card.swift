import SwiftUI

struct CardView: View {
    let title: String
    let description: String
    let price: String
    let action: () -> Void

    init(
        title: String,
        description: String,
        price: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.description = description
        self.price = price
        self.action = action
    }
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                titleView
                descriptionView
                priceView
            }

            Spacer()

            buttonView
        }
    }
}

private extension CardView {
    var titleView: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
    
    var descriptionView: some View {
        Text(description)
            .font(.subheadline)
            .foregroundColor(Color.gray)
            .lineLimit(2)
    }
    
    var priceView: some View {
        Text(price)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
    
    var buttonView: some View {
        Button(action: action) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.orange)
        }
    }
}
