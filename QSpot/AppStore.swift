import Foundation

final class AppStore: ObservableObject {
    @Published var selectedTab = 0
    @Published var favorites: Set<String> = ["luca", "marco"]
    @Published var selectedFilter = "Tutti"
    @Published var searchText = ""

    let filters = ["Tutti", "Online", "Nuovi", "Vicini"]

    let profiles: [DatingProfile] = [
        .init(id: "luca", name: "Luca", age: 24, distance: "A 300 m", bio: "Amo viaggiare, il mare e le serate spontanee.", interests: ["Viaggi", "Palestra", "Fotografia", "Musica"], imageName: "profile_luca", heroImageName: "hero_luca", online: true, verified: true, newProfile: false),
        .init(id: "marco", name: "Marco", age: 28, distance: "A 450 m", bio: "Ironico, diretto e sempre pronto a conoscere persone nuove.", interests: ["Cinema", "Fitness", "Cucina"], imageName: "profile_marco", heroImageName: "profile_marco", online: true, verified: true, newProfile: false),
        .init(id: "andrea", name: "Andrea", age: 26, distance: "A 600 m", bio: "Fotografia, arte e conversazioni senza fretta.", interests: ["Foto", "Arte", "Viaggi"], imageName: "profile_andrea", heroImageName: "profile_andrea", online: true, verified: true, newProfile: true),
        .init(id: "matteo", name: "Matteo", age: 31, distance: "A 1,2 km", bio: "Mare, musica e persone autentiche.", interests: ["Mare", "Concerti", "Sport"], imageName: "profile_matteo", heroImageName: "beach_luca", online: true, verified: false, newProfile: false),
        .init(id: "gabriele", name: "Gabriele", age: 29, distance: "A 1,8 km", bio: "Semplice, curioso e sempre in movimento.", interests: ["Weekend", "Food", "Podcast"], imageName: "profile_gabriele", heroImageName: "profile_gabriele", online: false, verified: false, newProfile: true),
        .init(id: "daniele", name: "Daniele", age: 27, distance: "A 2,1 km", bio: "Cerco nuove conoscenze e belle energie.", interests: ["Design", "Musica", "Caffè"], imageName: "profile_daniele", heroImageName: "profile_daniele", online: true, verified: true, newProfile: false)
    ]

    lazy var chats: [ChatItem] = [
        .init(profile: profiles[0], message: "Ciao! Come va?", time: "21:45", unread: 2),
        .init(profile: profiles[1], message: "Domani sei libero?", time: "20:12", unread: 1),
        .init(profile: profiles[2], message: "Ti va di vederci?", time: "19:08", unread: 0),
        .init(profile: profiles[3], message: "📷 Foto", time: "18:33", unread: 0),
        .init(profile: profiles[4], message: "Scrivi qualcosa…", time: "17:50", unread: 0)
    ]

    func toggleFavorite(_ profile: DatingProfile) {
        if favorites.contains(profile.id) {
            favorites.remove(profile.id)
        } else {
            favorites.insert(profile.id)
        }
    }

    var visibleProfiles: [DatingProfile] {
        profiles.filter { profile in
            let matchesSearch = searchText.isEmpty || profile.name.localizedCaseInsensitiveContains(searchText)
            let matchesFilter: Bool
            switch selectedFilter {
            case "Online": matchesFilter = profile.online
            case "Nuovi": matchesFilter = profile.newProfile
            case "Vicini": matchesFilter = ["luca", "marco", "andrea"].contains(profile.id)
            default: matchesFilter = true
            }
            return matchesSearch && matchesFilter
        }
    }
}
