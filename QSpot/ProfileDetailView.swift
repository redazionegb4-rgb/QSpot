import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject var store: AppStore
    let profile: DatingProfile

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 18) {
                    hero
                    about
                    interests
                    actions
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(AppTheme.gradient)
                .frame(height: 390)
                .overlay(
                    Image(systemName: profile.symbol)
                        .font(.system(size: 145, weight: .ultraLight))
                        .foregroundStyle(.white.opacity(0.88))
                )

            LinearGradient(colors: [.clear, .black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))

            VStack(alignment: .leading, spacing: 7) {
                HStack {
                    Text("\(profile.name), \(profile.age)")
                        .font(.system(size: 30, weight: .black, design: .rounded))
                    if profile.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(AppTheme.cyan)
                    }
                }
                Text(profile.headline)
                    .foregroundStyle(.white.opacity(0.86))
                Label(profile.distance, systemImage: "location.fill")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.72))
            }
            .padding(22)
        }
    }

    private var about: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Su di me")
                .font(.title3.bold())
            Text(profile.bio)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassCard()
    }

    private var interests: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Interessi")
                .font(.title3.bold())
            FlowLayout(spacing: 8) {
                ForEach(profile.interests, id: \.self) { interest in
                    Text(interest)
                        .font(.subheadline.weight(.semibold))
                        .padding(.horizontal, 13)
                        .padding(.vertical, 9)
                        .background(AppTheme.surfaceStrong)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassCard()
    }

    private var actions: some View {
        HStack(spacing: 12) {
            Button {
                store.toggleFavorite(profile)
            } label: {
                Image(systemName: store.favorites.contains(profile.id) ? "heart.fill" : "heart")
                    .font(.title3.bold())
                    .frame(width: 58, height: 58)
                    .background(AppTheme.surfaceStrong)
                    .clipShape(Circle())
            }

            Button {
            } label: {
                Label("Scrivi", systemImage: "paperplane.fill")
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(AppTheme.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
    }
}

struct FlowLayout<Content: View>: View {
    let spacing: CGFloat
    @ViewBuilder var content: Content

    init(spacing: CGFloat = 8, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        HStack(spacing: spacing) { content }
    }
}
