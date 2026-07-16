import Foundation

struct DatingProfile: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let age: Int
    let distance: String
    let headline: String
    let bio: String
    let interests: [String]
    let symbol: String
    let isOnline: Bool
    let isVerified: Bool
}

struct ChatPreview: Identifiable {
    let id = UUID()
    let profile: DatingProfile
    let message: String
    let time: String
    let unread: Int
}
