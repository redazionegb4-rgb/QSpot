import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            DiscoverView()
                .tag(0)
                .tabItem { Label("Scopri", systemImage: "square.grid.2x2.fill") }

            FavoritesView()
                .tag(1)
                .tabItem { Label("Preferiti", systemImage: "heart.fill") }

            MessagesView()
                .tag(2)
                .tabItem { Label("Messaggi", systemImage: "bubble.left.and.bubble.right.fill") }

            MyProfileView()
                .tag(3)
                .tabItem { Label("Profilo", systemImage: "person.crop.circle.fill") }
        }
        .tint(AppTheme.pink)
    }
}
