import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var store: AppStore

    private var items: [DatingProfile] {
        store.profiles.filter { store.favorites.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background.ignoresSafeArea()

                if items.isEmpty {
                    ContentUnavailableView(
                        "Nessun preferito",
                        systemImage: "heart",
                        description: Text("Tocca il cuore sui profili che ti interessano.")
                    )
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(items) { profile in
                                NavigationLink(value: profile) {
                                    ProfileTile(profile: profile)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(16)
                    }
                }
            }
            .navigationTitle("Preferiti")
            .navigationDestination(for: DatingProfile.self) { ProfileDetailView(profile: $0) }
        }
    }
}
