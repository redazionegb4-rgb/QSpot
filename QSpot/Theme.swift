import SwiftUI

extension Color {
    static let appBackground = Color(red: 0.045, green: 0.047, blue: 0.075)
    static let appSurface = Color(red: 0.085, green: 0.088, blue: 0.13)
    static let appPurple = Color(red: 0.49, green: 0.29, blue: 1.0)
    static let appPink = Color(red: 1.0, green: 0.27, blue: 0.58)
    static let appCyan = Color(red: 0.18, green: 0.78, blue: 1.0)
}

struct GlassCard: ViewModifier {
    var radius: CGFloat = 26
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: radius, style: .continuous).stroke(.white.opacity(0.09), lineWidth: 1))
    }
}

extension View {
    func glassCard(radius: CGFloat = 26) -> some View { modifier(GlassCard(radius: radius)) }
}

struct AppBackground: View {
    var body: some View {
        ZStack {
            Color.appBackground
            Circle().fill(Color.appPurple.opacity(0.24)).frame(width: 330).blur(radius: 100).offset(x: -170, y: -330)
            Circle().fill(Color.appPink.opacity(0.18)).frame(width: 280).blur(radius: 100).offset(x: 180, y: 270)
        }
        .ignoresSafeArea()
    }
}
