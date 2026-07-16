import SwiftUI

struct ProfileDetailView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) private var dismiss
    let profile: DatingProfile

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                hero
                detailArea
            }
        }
        .background(QTheme.background)
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            Image(profile.heroImageName)
                .resizable()
                .scaledToFill()
                .frame(height: 475)
                .clipped()

            LinearGradient(
                colors: [.black.opacity(0.05), .clear, QTheme.background.opacity(0.98)],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 7) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.system(size: 30, weight: .black, design: .rounded))
                    if profile.verified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(QTheme.blue)
                    }
                }
                HStack(spacing: 7) {
                    Circle().fill(profile.online ? QTheme.green : .gray).frame(width: 8, height: 8)
                    Text(profile.distance)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.white.opacity(0.78))
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 25)

            VStack {
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                            .frame(width: 42, height: 42)
                            .background(.black.opacity(0.38))
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button {} label: {
                        Image(systemName: "ellipsis")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                            .frame(width: 42, height: 42)
                            .background(.black.opacity(0.38))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.top, 52)
        }
        .frame(height: 475)
    }

    private var detailArea: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text(profile.bio)
                .font(.body)
                .foregroundStyle(.white.opacity(0.90))
                .lineSpacing(4)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(profile.interests, id: \.self) { interest in
                        Text(interest)
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 12)
                            .frame(height: 34)
                            .background(QTheme.panelRaised)
                            .clipShape(Capsule())
                    }
                }
            }

            HStack(spacing: 18) {
                ActionCircle(icon: "face.smiling.inverse", tint: QTheme.yellow)
                ActionCircle(icon: "ellipsis.message.fill", tint: QTheme.violet)
                Button {
                    store.toggleFavorite(profile)
                } label: {
                    ActionCircleContent(
                        icon: store.favorites.contains(profile.id) ? "star.fill" : "star",
                        tint: store.favorites.contains(profile.id) ? QTheme.yellow : .white
                    )
                }
            }
            .frame(maxWidth: .infinity)

            Divider().overlay(Color.white.opacity(0.08))

            HStack {
                Text("Foto")
                    .font(.title3.bold())
                Spacer()
                Text("Vedi tutte")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(QTheme.blue)
            }

            HStack(spacing: 9) {
                ForEach([profile.imageName, profile.heroImageName, "beach_luca"], id: \.self) { name in
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 118)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 32)
    }
}

struct ActionCircle: View {
    let icon: String
    let tint: Color
    var body: some View {
        ActionCircleContent(icon: icon, tint: tint)
    }
}

struct ActionCircleContent: View {
    let icon: String
    let tint: Color
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 24, weight: .semibold))
            .foregroundStyle(tint)
            .frame(width: 66, height: 66)
            .background(QTheme.panelRaised)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white.opacity(0.08)))
    }
}
