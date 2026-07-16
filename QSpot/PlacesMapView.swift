import SwiftUI
import MapKit

struct PlacesMapView: View {
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    @State private var selectedPlace: QueerPlace?

    var body: some View {
        Map(position: $position, selection: $selectedPlace) {
            UserAnnotation()
            ForEach(DemoData.places) { place in
                Marker(place.name, systemImage: place.symbol, coordinate: place.coordinate)
                    .tint(Color.qPurple)
                    .tag(place)
            }
        }
        .mapControls {
            MapCompass()
            MapUserLocationButton()
            MapScaleView()
        }
        .safeAreaInset(edge: .bottom) {
            if let selectedPlace {
                NavigationLink(value: selectedPlace) {
                    PlaceRow(place: selectedPlace)
                        .padding(10)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 22))
                        .padding()
                }
                .buttonStyle(.plain)
            }
        }
        .navigationTitle("Mappa")
        .navigationDestination(for: QueerPlace.self) { place in PlaceDetailView(place: place) }
    }
}

struct PlaceRow: View {
    let place: QueerPlace
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: place.symbol)
                .font(.title2)
                .frame(width: 50, height: 50)
                .background(Color.qPurple.opacity(0.12), in: RoundedRectangle(cornerRadius: 15))
                .foregroundStyle(Color.qPurple)
            VStack(alignment: .leading, spacing: 4) {
                Text(place.name).font(.headline)
                Text("\(place.category) · \(place.distance)").font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            Text(place.isOpen ? "Aperto" : "Chiuso")
                .font(.caption.bold())
                .foregroundStyle(place.isOpen ? .green : .red)
        }
    }
}

struct PlaceDetailView: View {
    let place: QueerPlace
    @AppStorage("favoritePlaces") private var favoritePlaces = ""

    private var isFavorite: Bool { favoritePlaces.split(separator: "|").map(String.init).contains(place.name) }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                RoundedRectangle(cornerRadius: 28)
                    .fill(LinearGradient(colors: [Color.qBlue.opacity(0.8), Color.qPurple.opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height: 280)
                    .overlay(Image(systemName: place.symbol).font(.system(size: 82)).foregroundStyle(.white))

                Text(place.name).font(.largeTitle.bold())
                Text(place.category).font(.title3).foregroundStyle(.secondary)
                Label(place.address, systemImage: "mappin.and.ellipse")
                Label(place.distance, systemImage: "figure.walk")
                Label(place.isOpen ? "Aperto adesso" : "Chiuso", systemImage: "clock.fill")
                    .foregroundStyle(place.isOpen ? .green : .red)

                Button {
                    toggleFavorite()
                } label: {
                    Label(isFavorite ? "Rimuovi dai preferiti" : "Aggiungi ai preferiti", systemImage: isFavorite ? "heart.slash.fill" : "heart.fill")
                        .frame(maxWidth: .infinity).padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.qPink)

                Button {
                    let item = MKMapItem(placemark: MKPlacemark(coordinate: place.coordinate))
                    item.name = place.name
                    item.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
                } label: {
                    Label("Apri indicazioni", systemImage: "arrow.triangle.turn.up.right.diamond.fill")
                        .frame(maxWidth: .infinity).padding()
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }

    private func toggleFavorite() {
        var names = Set(favoritePlaces.split(separator: "|").map(String.init))
        if names.contains(place.name) { names.remove(place.name) } else { names.insert(place.name) }
        favoritePlaces = names.sorted().joined(separator: "|")
    }
}
