import SwiftUI

enum AppTheme {
    static let background = Color(red: 0.035, green: 0.04, blue: 0.075)
    static let surface = Color.white.opacity(0.075)
    static let surfaceStrong = Color.white.opacity(0.12)
    static let purple = Color(red: 0.58, green: 0.25, blue: 1.0)
    static let pink = Color(red: 1.0, green: 0.2, blue: 0.56)
    static let cyan = Color(red: 0.18, green: 0.86, blue: 1.0)

    static let gradient = LinearGradient(
        colors: [purple, pink],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct GlassCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
    }
}

extension View {
    func glassCard() -> some View { modifier(GlassCard()) }
}
