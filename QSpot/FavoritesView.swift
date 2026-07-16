import SwiftUI

struct FavoritesView: View {
    @AppStorage("favoritePlaces") private var favoritePlaces = ""

    private var favorites: [QueerPlace] {
        let names = Set(favoritePlaces.split(separator: "|").map(String.init))
        return DemoData.places.filter { names.contains($0.name) }
    }

    var body: some View {
        Group {
            if favorites.isEmpty {
                ContentUnavailableView("Nessun preferito", systemImage: "heart", description: Text("Salva i luoghi che vuoi ritrovare velocemente."))
            } else {
                List(favorites) { place in
                    NavigationLink(value: place) { PlaceRow(place: place) }
                }
            }
        }
        .navigationTitle("Preferiti")
        .navigationDestination(for: QueerPlace.self) { place in PlaceDetailView(place: place) }
    }
}
