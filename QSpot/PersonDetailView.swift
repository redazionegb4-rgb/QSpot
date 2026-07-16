import SwiftUI

struct PersonDetailView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) private var dismiss
    let person: Person

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                hero
                content
            }
        }
        .background(Theme.bg)
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            Image(person.hero)
                .resizable()
                .scaledToFill()
                .frame(height: 520)
                .clipped()

            LinearGradient(
                colors: [.black.opacity(0.12), .clear, Theme.bg],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 7) {
                HStack(spacing: 7) {
                    Text("\(person.name), \(person.age)")
                        .font(.system(size: 31, weight: .black))
                    if person.verified {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(Theme.accent)
                    }
                }

                HStack(spacing: 7) {
                    Circle()
                        .fill(person.online ? Color.green : Color.gray)
                        .frame(width: 8, height: 8)
                    Text(person.distance)
                        .foregroundStyle(Theme.secondaryText)
                }
            }
            .padding(.horizontal, 18)
            .padding(.bottom, 24)

            VStack {
                HStack {
                    circleButton("chevron.left") { dismiss() }
                    Spacer()
                    circleButton("ellipsis") {}
                }
                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.top, 52)
        }
        .frame(height: 520)
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(person.bio)
                .font(.body)
                .lineSpacing(4)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(person.interests, id: \.self) { interest in
                        Text(interest)
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 12)
                            .frame(height: 32)
                            .background(Theme.surface)
                            .clipShape(Capsule())
                    }
                }
            }

            HStack(spacing: 10) {
                Button {
                    store.toggle(person)
                } label: {
                    Image(systemName: store.favorites.contains(person.id) ? "star.fill" : "star")
                        .font(.title3.bold())
                        .foregroundStyle(.black)
                        .frame(width: 56, height: 56)
                        .background(Theme.accent)
                        .clipShape(Circle())
                }

                Button {} label: {
                    Label("Invia messaggio", systemImage: "paperplane.fill")
                        .font(.headline.bold())
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Theme.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                }
            }

            HStack {
                Text("Foto")
                    .font(.title3.bold())
                Spacer()
                Text("Vedi tutte")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Theme.accent)
            }

            HStack(spacing: 8) {
                ForEach([person.image, person.hero, "hero2"], id: \.self) { name in
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 112)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 28)
    }

    private func circleButton(_ icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(width: 42, height: 42)
                .background(.black.opacity(0.42))
                .clipShape(Circle())
        }
    }
}
