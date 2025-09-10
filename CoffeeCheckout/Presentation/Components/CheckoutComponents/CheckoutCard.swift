import SwiftUI

struct CheckoutCard<Content: View>: View {
    var content: Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 10) {
                    self.content
                }
                .padding()
            }
        }
    }
}
