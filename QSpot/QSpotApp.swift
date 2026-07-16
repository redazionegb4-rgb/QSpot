import SwiftUI

@main
struct QSpotApp: App {
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome = false

    var body: some Scene {
        WindowGroup {
            Group {
                if hasSeenWelcome {
                    MainTabView()
                } else {
                    WelcomeView()
                }
            }
            .preferredColorScheme(nil)
        }
    }
}
