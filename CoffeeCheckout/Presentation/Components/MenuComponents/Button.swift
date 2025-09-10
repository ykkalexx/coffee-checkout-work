import SwiftUI

struct OrangeButton<Content: View>: View {
    let content: Content
    let action: () -> Void
    
    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
         self.action = action
         self.content = content()
     }
    
    var body: some View {
        Button(action: action) {
            content
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.orange)
                .cornerRadius(40)
        }
    }
}
