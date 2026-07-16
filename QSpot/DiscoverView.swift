import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    header
                    filterBar

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 10),
                            GridItem(.flexible(), spacing: 10)
                        ],
                        spacing: 10
                    ) {
                        ForEach(store.visibleProfiles) { profile in
                            NavigationLink(value: profile) {
                                ProfileCard(profile: profile)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.top, 8)
                .padding(.bottom, 18)
            }
            .background(QTheme.background)
            .navigationDestination(for: DatingProfile.self) { profile in
                ProfileDetailView(profile: profile)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var header: some View {
        VStack(spacing: 14) {
            HStack {
                Text("QSPOT")
                    .font(.system(size: 27, weight: .black, design: .rounded))
                    .tracking(-1)
                Spacer()
                Button {} label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(QTheme.blue)
                        .frame(width: 42, height: 42)
                        .background(QTheme.panelRaised)
                        .clipShape(Circle())
                }
            }

            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Cerca", text: $store.searchText)
                    .textInputAutocapitalization(.never)
            }
            .padding(.horizontal, 14)
            .frame(height: 44)
            .background(QTheme.panel)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 9) {
                ForEach(store.filters, id: \.self) { filter in
                    Button {
                        withAnimation(.easeOut(duration: 0.2)) {
                            store.selectedFilter = filter
                        }
                    } label: {
                        HStack(spacing: 6) {
                            if filter == "Online" {
                                Circle().fill(QTheme.green).frame(width: 7, height: 7)
                            }
                            Text(filter)
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 15)
                        .frame(height: 38)
                        .background(
                            store.selectedFilter == filter
                            ? AnyShapeStyle(QTheme.accentGradient)
                            : AnyShapeStyle(QTheme.panel)
                        )
                        .clipShape(Capsule())
                    }
                }
            }
        }
    }
}

struct ProfileCard: View {
    @EnvironmentObject var store: AppStore
    let profile: DatingProfile

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(profile.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 236)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.15), .black.opacity(0.96)],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.headline.bold())
                    if profile.verified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.caption)
                            .foregroundStyle(QTheme.blue)
                    }
                }
                HStack(spacing: 6) {
                    Circle()
                        .fill(profile.online ? QTheme.green : Color.gray)
                        .frame(width: 7, height: 7)
                    Text(profile.distance)
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.78))
                }
            }
            .padding(11)

            VStack {
                HStack {
                    Spacer()
                    Button {
                        store.toggleFavorite(profile)
                    } label: {
                        Image(systemName: store.favorites.contains(profile.id) ? "star.fill" : "star")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(store.favorites.contains(profile.id) ? QTheme.yellow : .white)
                            .frame(width: 35, height: 35)
                            .background(.black.opacity(0.32))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .padding(9)
        }
        .frame(height: 236)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }
}
