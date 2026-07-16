import Foundation
import CoreLocation

struct PersonProfile: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let age: Int
    let distance: String
    let city: String
    let bio: String
    let symbol: String
    let isOnline: Bool
}

struct QueerPlace: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let category: String
    let city: String
    let distance: String
    let address: String
    let symbol: String
    let latitude: Double
    let longitude: Double
    let isOpen: Bool

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

enum DemoData {
    static let people: [PersonProfile] = [
        .init(name: "Luca", age: 28, distance: "1,2 km", city: "Roma", bio: "Aperitivi, cinema e viaggi improvvisati.", symbol: "person.crop.circle.fill", isOnline: true),
        .init(name: "Sam", age: 25, distance: "2,8 km", city: "Roma", bio: "Cerco nuove amicizie e serate tranquille.", symbol: "sparkles", isOnline: true),
        .init(name: "Andrea", age: 31, distance: "4,1 km", city: "Roma", bio: "Musica live, arte e passeggiate notturne.", symbol: "music.note", isOnline: false),
        .init(name: "Alex", age: 27, distance: "5,6 km", city: "Roma", bio: "Sempre alla ricerca di posti nuovi.", symbol: "camera.fill", isOnline: true)
    ]

    static let places: [QueerPlace] = [
        .init(name: "Rainbow Bar", category: "Bar LGBTQ+", city: "Roma", distance: "900 m", address: "Via del Centro 18", symbol: "wineglass.fill", latitude: 41.9009, longitude: 12.4833, isOpen: true),
        .init(name: "Pride Garden", category: "Parco e ritrovo", city: "Roma", distance: "1,8 km", address: "Viale Verde 7", symbol: "leaf.fill", latitude: 41.8950, longitude: 12.4900, isOpen: true),
        .init(name: "Q Club", category: "Discoteca", city: "Roma", distance: "3,2 km", address: "Via della Notte 22", symbol: "music.mic", latitude: 41.9120, longitude: 12.4750, isOpen: false),
        .init(name: "Casa Arcobaleno", category: "Associazione", city: "Roma", distance: "4,5 km", address: "Piazza Insieme 4", symbol: "heart.circle.fill", latitude: 41.8870, longitude: 12.5050, isOpen: true)
    ]
}
