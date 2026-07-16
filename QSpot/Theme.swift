import SwiftUI

extension Color {
    static let qPurple = Color(red: 0.49, green: 0.22, blue: 0.93)
    static let qPink = Color(red: 0.94, green: 0.24, blue: 0.58)
    static let qBlue = Color(red: 0.20, green: 0.55, blue: 0.96)
}

struct GradientCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(18)
            .background(
                LinearGradient(colors: [Color.qPurple.opacity(0.95), Color.qPink.opacity(0.85)], startPoint: .topLeading, endPoint: .bottomTrailing),
                in: RoundedRectangle(cornerRadius: 24, style: .continuous)
            )
            .foregroundStyle(.white)
            .shadow(color: Color.qPurple.opacity(0.18), radius: 14, y: 8)
    }
}

extension View {
    func gradientCard() -> some View { modifier(GradientCard()) }
}
