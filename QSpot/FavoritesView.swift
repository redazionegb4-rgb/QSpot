import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var store: AppStore

    var favoriteProfiles: [DatingProfile] {
        store.profiles.filter { store.favorites.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Preferiti")
                        .font(.system(size: 29, weight: .bold))
                        .padding(.top, 10)

                    HStack(spacing: 8) {
                        SegmentChip(title: "Tutti", active: true)
                        SegmentChip(title: "Persone")
                        SegmentChip(title: "Album")
                    }

                    LazyVGrid(
                        columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)],
                        spacing: 10
                    ) {
                        ForEach(favoriteProfiles) { profile in
                            NavigationLink(value: profile) {
                                ProfileCard(profile: profile)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 18)
            }
            .background(QTheme.background)
            .navigationDestination(for: DatingProfile.self) { ProfileDetailView(profile: $0) }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct SegmentChip: View {
    let title: String
    var active = false
    var body: some View {
        Text(title)
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 15)
            .frame(height: 37)
            .background(active ? QTheme.purple.opacity(0.42) : QTheme.panel)
            .clipShape(Capsule())
            .foregroundStyle(active ? QTheme.violet : .white.opacity(0.75))
    }
}
