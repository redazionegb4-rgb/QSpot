import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var store: AppStore

    private var filteredProfiles: [DatingProfile] {
        guard !store.searchText.isEmpty else { return store.profiles }
        return store.profiles.filter {
            $0.name.localizedCaseInsensitiveContains(store.searchText) ||
            $0.headline.localizedCaseInsensitiveContains(store.searchText)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    AppTheme.background
                    AppTheme.subtleGradient.opacity(0.8)
                }
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        header
                        quickFilters

                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)], spacing: 12) {
                            ForEach(filteredProfiles) { profile in
                                NavigationLink(value: profile) {
                                    ProfileTile(profile: profile)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
            .navigationDestination(for: DatingProfile.self) { profile in
                ProfileDetailView(profile: profile)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var header: some View {
        VStack(spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 10) {
                        Image(systemName: "q.circle.fill")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(AppTheme.gradient)
                        Text("QSpot")
                            .font(.system(size: 31, weight: .black, design: .rounded))
                    }
                    Text("Persone vicino a te")
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button {
                } label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title3.bold())
                        .frame(width: 46, height: 46)
                        .background(AppTheme.surfaceStrong)
                        .clipShape(Circle())
                }
            }

            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Cerca persone", text: $store.searchText)
                    .textInputAutocapitalization(.never)
            }
            .padding(.horizontal, 16)
            .frame(height: 50)
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .padding(.top, 14)
    }

    private var quickFilters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                FilterChip(title: "Tutti", icon: "sparkles", active: true)
                FilterChip(title: "Online", icon: "circle.fill")
                FilterChip(title: "Verificati", icon: "checkmark.seal.fill")
                FilterChip(title: "Più vicini", icon: "location.fill")
            }
        }
    }
}

struct FilterChip: View {
    let title: String
    let icon: String
    var active = false

    var body: some View {
        HStack(spacing: 7) {
            Image(systemName: icon)
            Text(title)
        }
        .font(.subheadline.weight(.semibold))
        .padding(.horizontal, 14)
        .frame(height: 40)
        .background(active ? AnyShapeStyle(AppTheme.gradient) : AnyShapeStyle(AppTheme.surface))
        .clipShape(Capsule())
    }
}

struct ProfileTile: View {
    @EnvironmentObject var store: AppStore
    let profile: DatingProfile

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [AppTheme.violet.opacity(0.75), AppTheme.aqua.opacity(0.22), Color.black.opacity(0.88)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 250)

            Image(systemName: profile.symbol)
                .font(.system(size: 80, weight: .ultraLight))
                .foregroundStyle(Color.white.opacity(0.82))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 48)

            LinearGradient(colors: [.clear, .black.opacity(0.88)], startPoint: .top, endPoint: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 6) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.headline.bold())
                    if profile.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(AppTheme.aqua)
                    }
                }

                Text(profile.headline)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.84))
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Circle()
                        .fill(profile.isOnline ? AppTheme.success : Color.gray)
                        .frame(width: 7, height: 7)
                    Text(profile.distance)
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.7))
                }
            }
            .padding(14)

            VStack {
                HStack {
                    Spacer()
                    Button {
                        store.toggleFavorite(profile)
                    } label: {
                        Image(systemName: store.favorites.contains(profile.id) ? "heart.fill" : "heart")
                            .font(.headline)
                            .foregroundStyle(store.favorites.contains(profile.id) ? AppTheme.blue : .white)
                            .frame(width: 38, height: 38)
                            .background(.black.opacity(0.28))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .padding(12)
        }
        .frame(height: 250)
    }
}
