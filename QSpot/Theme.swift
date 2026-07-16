import SwiftUI

enum QTheme {
    static let background = Color(red: 0.018, green: 0.022, blue: 0.030)
    static let panel = Color(red: 0.055, green: 0.063, blue: 0.078)
    static let panelRaised = Color(red: 0.075, green: 0.084, blue: 0.102)
    static let purple = Color(red: 0.53, green: 0.18, blue: 1.0)
    static let violet = Color(red: 0.72, green: 0.12, blue: 1.0)
    static let blue = Color(red: 0.10, green: 0.62, blue: 1.0)
    static let cyan = Color(red: 0.10, green: 0.88, blue: 1.0)
    static let green = Color(red: 0.13, green: 0.91, blue: 0.55)
    static let yellow = Color(red: 1.0, green: 0.80, blue: 0.16)

    static let accentGradient = LinearGradient(
        colors: [purple, violet, blue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension View {
    func qPanel(cornerRadius: CGFloat = 22) -> some View {
        self
            .background(QTheme.panel)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(0.07), lineWidth: 1)
            )
    }
}
