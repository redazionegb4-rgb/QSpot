import Foundation

final class AppStore: ObservableObject {
    @Published var selectedTab = 0
    @Published var favorites: Set<UUID> = []
    @Published var searchText = ""

    let profiles: [DatingProfile] = [
        .init(name: "Luca", age: 28, distance: "650 m", headline: "Aperitivo e risate", bio: "Mi piacciono i viaggi improvvisati, la musica dal vivo e le persone sincere.", interests: ["Viaggi", "Musica", "Cinema"], symbol: "person.crop.circle.fill", isOnline: true, isVerified: true),
        .init(name: "Matteo", age: 31, distance: "1,2 km", headline: "Conosciamoci davvero", bio: "Sport, fotografia e cene tranquille. Cerco qualcosa di autentico.", interests: ["Sport", "Foto", "Cucina"], symbol: "figure.run.circle.fill", isOnline: true, isVerified: false),
        .init(name: "Andrea", age: 26, distance: "1,8 km", headline: "Nuovo in città", bio: "Sono appena arrivato e mi piacerebbe conoscere persone interessanti.", interests: ["Arte", "Design", "Caffè"], symbol: "camera.circle.fill", isOnline: false, isVerified: true),
        .init(name: "Marco", age: 34, distance: "2,5 km", headline: "Zero drammi", bio: "Ironico, diretto e sempre pronto a partire per un weekend.", interests: ["Weekend", "Mare", "Serie TV"], symbol: "airplane.circle.fill", isOnline: true, isVerified: true),
        .init(name: "Samuele", age: 29, distance: "3,1 km", headline: "Parliamo?", bio: "Amo gli animali, la palestra e le conversazioni che durano ore.", interests: ["Animali", "Fitness", "Podcast"], symbol: "pawprint.circle.fill", isOnline: false, isVerified: false),
        .init(name: "Davide", age: 30, distance: "4 km", headline: "Vivo leggero", bio: "Buon cibo, ironia e niente complicazioni inutili.", interests: ["Food", "Humor", "Concerti"], symbol: "music.note.list", isOnline: true, isVerified: true)
    ]

    lazy var chats: [ChatPreview] = [
        .init(profile: profiles[0], message: "Ciao! Come va la serata?", time: "21:08", unread: 2),
        .init(profile: profiles[3], message: "Domani sei libero?", time: "19:42", unread: 0),
        .init(profile: profiles[1], message: "Hai visto quella serie?", time: "Ieri", unread: 1)
    ]

    func toggleFavorite(_ profile: DatingProfile) {
        if favorites.contains(profile.id) {
            favorites.remove(profile.id)
        } else {
            favorites.insert(profile.id)
        }
    }
}
