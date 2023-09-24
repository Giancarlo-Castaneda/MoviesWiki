import SwiftUI

struct ShadowModifier: ViewModifier {
    var shadowColor: Color = .black

    func body(content: Content) -> some View {
        content
            .shadow(color: shadowColor.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: shadowColor.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}
