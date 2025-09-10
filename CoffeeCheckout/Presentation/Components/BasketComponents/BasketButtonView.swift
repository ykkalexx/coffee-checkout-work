import SwiftUI


struct BasketButtonView: View {
    @ObservedObject var basketManager: BasketManagement
    
    var body: some View {
        Button(action: {
            print("Basket button tapped!")
        }) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "basket")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(5)
                
                if basketManager.fetchTotalQuanity() > 0 {
                    Text("\(basketManager.fetchTotalQuanity())")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.orange)
                        .clipShape(Circle())
                        .offset(x: 10, y: -10)
                }
            }
        }
    }
}
