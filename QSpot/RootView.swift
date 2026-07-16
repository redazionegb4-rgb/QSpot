import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        ZStack {
            QTheme.background.ignoresSafeArea()

            Group {
                switch store.selectedTab {
                case 1: FavoritesView()
                case 2: MessagesView()
                case 3: MyProfileView()
                default: DiscoverView()
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            QBottomBar()
        }
    }
}

struct QBottomBar: View {
    @EnvironmentObject var store: AppStore

    private let items = [
        ("face.smiling.inverse", "Esplora"),
        ("heart", "Preferiti"),
        ("ellipsis.message", "Chat"),
        ("person", "Profilo")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.32, dampingFraction: 0.82)) {
                        store.selectedTab = index
                    }
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: items[index].0)
                            .font(.system(size: 20, weight: .semibold))
                        Text(items[index].1)
                            .font(.caption2.weight(.medium))
                    }
                    .foregroundStyle(store.selectedTab == index ? QTheme.violet : Color.white.opacity(0.62))
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .background(
                        store.selectedTab == index
                        ? QTheme.purple.opacity(0.13)
                        : Color.clear
                    )
                }
            }
        }
        .padding(.horizontal, 8)
        .background(.ultraThinMaterial)
        .background(Color.black.opacity(0.72))
        .overlay(alignment: .top) {
            Rectangle().fill(Color.white.opacity(0.08)).frame(height: 1)
        }
    }
}
