import SwiftUI

struct BasketCard<Content: View>: View {
    @State private var itemQuantity: Int = 1
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardC)
                
            HStack {
                content
                
                Spacer()
                
                QuantityButton(quantity: $itemQuantity)
            }
            .padding(16)
        }
    }
}
