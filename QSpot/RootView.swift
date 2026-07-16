import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            NavigationStack { HomeView() }
                .tabItem { Label("Home", systemImage: "house.fill") }

            NavigationStack { ExploreView() }
                .tabItem { Label("Persone", systemImage: "person.2.fill") }

            NavigationStack { PlacesMapView() }
                .tabItem { Label("Mappa", systemImage: "map.fill") }

            NavigationStack { FavoritesView() }
                .tabItem { Label("Preferiti", systemImage: "heart.fill") }

            NavigationStack { ProfileView() }
                .tabItem { Label("Profilo", systemImage: "person.crop.circle.fill") }
        }
        .tint(Color.qPurple)
    }
}
