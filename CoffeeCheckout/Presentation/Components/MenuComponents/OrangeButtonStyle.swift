import SwiftUI

struct OrangeButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .background(Color.orange)
            .cornerRadius(40)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
    
}
