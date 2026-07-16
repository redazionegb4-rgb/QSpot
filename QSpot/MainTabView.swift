import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack { HomeView() }
                .tabItem { Label("Home", systemImage: "house.fill") }
            NavigationStack { DiscoverView() }
                .tabItem { Label("Scopri", systemImage: "person.2.fill") }
            NavigationStack { PlacesView() }
                .tabItem { Label("Mappa", systemImage: "map.fill") }
            NavigationStack { EventsView() }
                .tabItem { Label("Eventi", systemImage: "calendar") }
            NavigationStack { ProfileView() }
                .tabItem { Label("Profilo", systemImage: "person.crop.circle.fill") }
        }
        .tint(Color.appPurple)
    }
}
