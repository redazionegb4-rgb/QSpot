import SwiftUI

enum AppTheme {
    static let background = Color(red: 0.025, green: 0.03, blue: 0.045)
    static let backgroundRaised = Color(red: 0.055, green: 0.06, blue: 0.085)
    static let surface = Color.white.opacity(0.065)
    static let surfaceStrong = Color.white.opacity(0.11)
    static let blue = Color(red: 0.12, green: 0.55, blue: 1.0)
    static let violet = Color(red: 0.43, green: 0.31, blue: 0.96)
    static let aqua = Color(red: 0.22, green: 0.87, blue: 0.92)
    static let success = Color(red: 0.22, green: 0.84, blue: 0.52)

    static let gradient = LinearGradient(
        colors: [blue, violet],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let subtleGradient = LinearGradient(
        colors: [blue.opacity(0.38), violet.opacity(0.18), Color.clear],
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
                    .stroke(Color.white.opacity(0.075), lineWidth: 1)
            )
    }
}

extension View {
    func glassCard() -> some View { modifier(GlassCard()) }
}
