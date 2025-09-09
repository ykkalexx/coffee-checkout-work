import SwiftUI

struct BackgroundColorStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .background(Color.mainBg)
    }
}
