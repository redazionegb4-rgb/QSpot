import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        ZStack(alignment:.bottom) {
            Theme.bg.ignoresSafeArea()
            Group {
                switch store.tab {
                case 1: FavoritesView()
                case 2: ChatsView()
                case 3: LikesView()
                case 4: ProfileView()
                default: DiscoverView()
                }
            }.padding(.bottom,62)
            AppTabBar()
        }
    }
}

struct AppTabBar: View {
    @EnvironmentObject var store: AppStore
    let items=[("house.fill","Home"),("safari.fill","Scopri"),("bubble.left.fill","Chat"),("heart.fill","Like"),("person.fill","Profilo")]
    var body: some View {
        HStack(spacing:0) {
            ForEach(items.indices,id:\.self) { i in
                Button { withAnimation(.spring(response:0.3,dampingFraction:0.85)){store.tab=i} } label: {
                    VStack(spacing:4) {
                        Image(systemName:items[i].0).font(.system(size:18,weight:.semibold))
                        Text(items[i].1).font(.system(size:9,weight:.semibold))
                    }
                    .foregroundStyle(store.tab==i ? Theme.lilac : Color.white.opacity(0.44))
                    .frame(maxWidth:.infinity).frame(height:58)
                }
            }
        }
        .background(.ultraThinMaterial).background(Color.black.opacity(0.82))
        .overlay(alignment:.top){Rectangle().fill(Theme.line).frame(height:1)}
    }
}
