import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.leading,spacing:16) {
                    HStack { Text("Esplora").font(.system(size:29,weight:.bold)); Spacer(); Image(systemName:"slider.horizontal.3").foregroundStyle(Theme.lilac) }
                    HStack(spacing:8){chip("Per te",true);chip("Nuovi");chip("Vicino");chip("Online")}
                    LazyVGrid(columns:[GridItem(.flexible(),spacing:8),GridItem(.flexible(),spacing:8)],spacing:8) {
                        ForEach(store.people) { p in NavigationLink(value:p){SuggestedCard(person:p).frame(maxWidth:.infinity)}.buttonStyle(.plain) }
                    }
                }.padding(.horizontal,14).padding(.top,10).padding(.bottom,18)
            }
            .background(Theme.bg).navigationDestination(for:Person.self){PersonDetailView(person:$0)}.toolbar(.hidden,for:.navigationBar)
        }
    }
    private func chip(_ s:String,_ active:Bool=false)->some View { Text(s).font(.subheadline.weight(.semibold)).padding(.horizontal,14).frame(height:34).background(active ? Theme.purple : Theme.panel).clipShape(Capsule()) }
}
