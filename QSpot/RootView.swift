import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        ZStack(alignment: .bottom) {
            Theme.bg.ignoresSafeArea()

            Group {
                switch store.tab {
                case 1: FavoritesView()
                case 2: ChatsView()
                case 3: ProfileView()
                default: DiscoverView()
                }
            }
            .padding(.bottom, 70)

            PremiumTabBar()
        }
    }
}

struct PremiumTabBar: View {
    @EnvironmentObject var store: AppStore

    private let items = [
        ("square.grid.2x2.fill", "Scopri"),
        ("star.fill", "Preferiti"),
        ("bubble.left.and.bubble.right.fill", "Messaggi"),
        ("person.crop.circle.fill", "Profilo")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.28, dampingFraction: 0.82)) {
                        store.tab = index
                    }
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: items[index].0)
                            .font(.system(size: 19, weight: .semibold))
                        Text(items[index].1)
                            .font(.system(size: 10, weight: .semibold))
                    }
                    .foregroundStyle(store.tab == index ? Theme.accent : Color.white.opacity(0.42))
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                }
            }
        }
        .padding(.horizontal, 6)
        .background(.ultraThinMaterial)
        .background(Color.black.opacity(0.86))
        .overlay(alignment: .top) {
            Rectangle().fill(Theme.divider).frame(height: 1)
        }
    }
}
