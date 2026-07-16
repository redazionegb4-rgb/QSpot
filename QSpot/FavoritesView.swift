import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment:.leading, spacing:16) {
                    Text("Salvati")
                        .font(.system(size:29, weight:.bold))
                        .padding(.top,10)

                    LazyVGrid(columns:[GridItem(.flexible(), spacing:8),GridItem(.flexible(), spacing:8)], spacing:8) {
                        ForEach(store.people.filter{store.favorites.contains($0.id)}) { p in
                            NavigationLink(value:p) { PersonCard(person:p) }
                                .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal,12)
                .padding(.bottom,16)
            }
            .background(Theme.bg)
            .navigationDestination(for:Person.self){PersonDetailView(person:$0)}
            .toolbar(.hidden, for:.navigationBar)
        }
    }
}
