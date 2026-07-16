import Foundation
import CoreLocation

struct CommunityPerson: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let age: Int
    let headline: String
    let distance: String
    let city: String
    let symbol: String
    let colors: [String]
    let online: Bool
    let verified: Bool
}

struct CommunityPlace: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let category: String
    let neighborhood: String
    let distance: String
    let rating: Double
    let isOpen: Bool
    let symbol: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D { .init(latitude: latitude, longitude: longitude) }
}

struct CommunityEvent: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let venue: String
    let day: String
    let time: String
    let symbol: String
}

enum DemoContent {
    static let people = [
        CommunityPerson(name: "Luca", age: 29, headline: "Caffè, viaggi e cinema", distance: "800 m", city: "Roma", symbol: "face.smiling.inverse", colors: ["purple","pink"], online: true, verified: true),
        CommunityPerson(name: "Marco", age: 33, headline: "Cerco nuove amicizie", distance: "1,4 km", city: "Roma", symbol: "figure.walk", colors: ["cyan","blue"], online: true, verified: false),
        CommunityPerson(name: "Alex", age: 26, headline: "Musica e serate live", distance: "2,1 km", city: "Roma", symbol: "music.note", colors: ["orange","pink"], online: false, verified: true),
        CommunityPerson(name: "Sam", age: 31, headline: "Aperitivo questa sera?", distance: "3,2 km", city: "Roma", symbol: "sparkles", colors: ["green","cyan"], online: true, verified: true)
    ]

    static let places = [
        CommunityPlace(name: "Coming Out", category: "Bar LGBTQ+", neighborhood: "Colosseo", distance: "1,2 km", rating: 4.6, isOpen: true, symbol: "wineglass.fill", latitude: 41.8897, longitude: 12.4985),
        CommunityPlace(name: "Gay Village", category: "Evento e spettacoli", neighborhood: "EUR", distance: "7,8 km", rating: 4.5, isOpen: false, symbol: "music.mic", latitude: 41.8333, longitude: 12.4667),
        CommunityPlace(name: "Arcigay Roma", category: "Associazione", neighborhood: "San Giovanni", distance: "3,5 km", rating: 4.8, isOpen: true, symbol: "person.3.fill", latitude: 41.8831, longitude: 12.5090),
        CommunityPlace(name: "Villa Borghese", category: "Parco e incontro", neighborhood: "Centro", distance: "2,9 km", rating: 4.7, isOpen: true, symbol: "leaf.fill", latitude: 41.9142, longitude: 12.4922)
    ]

    static let events = [
        CommunityEvent(title: "Rainbow Aperitivo", venue: "Coming Out", day: "OGGI", time: "20:30", symbol: "wineglass.fill"),
        CommunityEvent(title: "Queer Karaoke", venue: "Zona Pigneto", day: "VEN 17", time: "22:00", symbol: "music.mic"),
        CommunityEvent(title: "Community Brunch", venue: "Trastevere", day: "DOM 19", time: "12:00", symbol: "cup.and.saucer.fill")
    ]
}
