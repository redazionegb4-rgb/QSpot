import Foundation

struct Person: Identifiable, Hashable {
    let id: String
    let name: String
    let age: Int
    let distance: String
    let image: String
    let hero: String
    let bio: String
    let online: Bool
    let verified: Bool
    let interests: [String]
}

struct ChatRow: Identifiable {
    let id = UUID()
    let person: Person
    let preview: String
    let time: String
    let unread: Int
}
