import SwiftUI

enum Theme {
    static let bg = Color(red: 0.025, green: 0.026, blue: 0.033)
    static let panel = Color(red: 0.070, green: 0.073, blue: 0.086)
    static let panel2 = Color(red: 0.095, green: 0.100, blue: 0.118)
    static let purple = Color(red: 0.48, green: 0.25, blue: 0.98)
    static let lilac = Color(red: 0.72, green: 0.58, blue: 1.00)
    static let green = Color(red: 0.17, green: 0.89, blue: 0.49)
    static let pink = Color(red: 0.97, green: 0.20, blue: 0.61)
    static let secondary = Color.white.opacity(0.62)
    static let line = Color.white.opacity(0.07)
    static let gradient = LinearGradient(colors:[lilac,purple], startPoint:.topLeading, endPoint:.bottomTrailing)
}
