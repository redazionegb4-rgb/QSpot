import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        ZStack {
            Theme.bg.ignoresSafeArea()

            Group {
                switch store.tab {
                case 1: FavoritesView()
                case 2: ChatsView()
                case 3: ProfileView()
                default: DiscoverView()
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            BottomBar()
        }
    }
}

struct BottomBar: View {
    @EnvironmentObject var store: AppStore
    let items = [
        ("square.grid.2x2.fill","Vicini"),
        ("star.fill","Salvati"),
        ("bubble.left.and.bubble.right.fill","Chat"),
        ("person.crop.circle.fill","Profilo")
    ]

    var body: some View {
        HStack {
            ForEach(items.indices, id:\.self) { i in
                Button {
                    store.tab = i
                } label: {
                    VStack(spacing:4) {
                        Image(systemName: items[i].0)
                            .font(.system(size:20, weight:.semibold))
                        Text(items[i].1)
                            .font(.caption2.weight(.semibold))
                    }
                    .foregroundStyle(store.tab == i ? Theme.accent : Color.white.opacity(0.48))
                    .frame(maxWidth:.infinity)
                    .frame(height:62)
                }
            }
        }
        .background(Color.black.opacity(0.96))
        .overlay(alignment:.top) {
            Rectangle().fill(Color.white.opacity(0.08)).frame(height:1)
        }
    }
}
