import SwiftUI

struct BasketButtonStyle: ButtonStyle {
    let quantity: Int

    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "basket.fill")
                .font(.title2)
                .foregroundColor(.white)

            if quantity > 0 {
                Text("\(quantity)")
                    .font(.caption2)
                    .bold()
                    .frame(width: 18, height: 18)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
        .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
        .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


