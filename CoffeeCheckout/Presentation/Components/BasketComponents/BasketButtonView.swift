import SwiftUI

struct BasketButtonView: View {
    let quantity: Int
    
    var body: some View {
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
    }
}

#Preview {
    VStack(spacing: 30) {
        BasketButtonView(quantity: 0)
        
        BasketButtonView(quantity: 5)
    }
    .padding()
    .background(Color.mainBg)
}
