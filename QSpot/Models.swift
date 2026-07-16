import Foundation

struct DatingProfile: Identifiable, Hashable {
    let id: String
    let name: String
    let age: Int
    let distance: String
    let bio: String
    let interests: [String]
    let imageName: String
    let heroImageName: String
    let online: Bool
    let verified: Bool
    let newProfile: Bool
}

struct ChatItem: Identifiable {
    let id = UUID()
    let profile: DatingProfile
    let message: String
    let time: String
    let unread: Int
}
