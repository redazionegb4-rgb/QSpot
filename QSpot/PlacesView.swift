import SwiftUI
import MapKit

struct PlacesView: View {
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964), span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09)))
    @State private var selected: CommunityPlace?

    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $position, selection: $selected) {
                UserAnnotation()
                ForEach(DemoContent.places) { place in
                    Marker(place.name, systemImage: place.symbol, coordinate: place.coordinate).tint(.appPurple).tag(place)
                }
            }.mapStyle(.standard(elevation: .realistic, pointsOfInterest: .including([.nightlife, .cafe, .park])))
            HStack(spacing: 12) {
                BrandMark(size: 44)
                VStack(alignment: .leading, spacing: 1) { Text("Mappa LGBTQ+").font(.headline); Text("Roma · posizione attiva").font(.caption).foregroundStyle(.secondary) }
                Spacer()
                Button(action: { position = .userLocation(fallback: position) }) { Image(systemName: "location.fill").frame(width: 43, height: 43).glassCard(radius: 15) }
            }.padding(12).glassCard(radius: 22).padding(.horizontal, 14).padding(.top, 8).foregroundStyle(.white)
        }
        .sheet(item: $selected) { place in PlaceDetailView(place: place).presentationDetents([.medium, .large]).presentationDragIndicator(.visible) }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct PlaceDetailView: View {
    let place: CommunityPlace
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            AppBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack { Button(action: { dismiss() }) { Image(systemName: "xmark").frame(width: 42, height: 42).glassCard(radius: 15) }; Spacer(); Button(action: {}) { Image(systemName: "heart").frame(width: 42, height: 42).glassCard(radius: 15) } }
                    ZStack { RoundedRectangle(cornerRadius: 30).fill(LinearGradient(colors: [.appPurple, .appPink], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(height: 220); Image(systemName: place.symbol).font(.system(size: 72)).foregroundStyle(.white) }
                    VStack(alignment: .leading, spacing: 8) { Text(place.name).font(.largeTitle.bold()); Text("\(place.category) · \(place.neighborhood)").foregroundStyle(.secondary); HStack { Label(String(format: "%.1f", place.rating), systemImage: "star.fill").foregroundStyle(.yellow); Text(place.distance); Spacer(); Text(place.isOpen ? "APERTO ORA" : "CHIUSO").font(.caption.bold()).foregroundStyle(place.isOpen ? .green : .secondary) } }
                    Text("Uno spazio selezionato dalla community. Controlla gli orari e raggiungilo direttamente con Apple Maps.").font(.body).foregroundStyle(.secondary)
                    Button(action: openMaps) { Label("Portami qui", systemImage: "arrow.triangle.turn.up.right.diamond.fill").font(.headline).frame(maxWidth: .infinity).padding(.vertical, 16).background(LinearGradient(colors: [.appPurple, .appPink], startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 18)).foregroundStyle(.white) }
                }.padding(18)
            }
        }.foregroundStyle(.white)
    }
    private func openMaps() {
        let item = MKMapItem(placemark: MKPlacemark(coordinate: place.coordinate)); item.name = place.name; item.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
