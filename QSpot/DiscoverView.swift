import SwiftUI

struct DiscoverView: View {
    @State private var search = ""
    @State private var selected = "Tutti"
    private let filters = ["Tutti", "Online", "Vicini", "Amicizia", "Eventi"]

    var filtered: [CommunityPerson] { search.isEmpty ? DemoContent.people : DemoContent.people.filter { $0.name.localizedCaseInsensitiveContains(search) } }

    var body: some View {
        ZStack {
            AppBackground()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Scopri").font(.system(size: 34, weight: .bold, design: .rounded))
                    HStack { Image(systemName: "magnifyingglass"); TextField("Cerca persone", text: $search).textInputAutocapitalization(.never) }.padding(15).glassCard(radius: 18)
                    ScrollView(.horizontal, showsIndicators: false) { HStack { ForEach(filters, id: \.self) { filter in Button(filter) { selected = filter }.font(.subheadline.bold()).padding(.horizontal, 16).padding(.vertical, 10).background(selected == filter ? Color.appPurple : Color.appSurface, in: Capsule()).foregroundStyle(.white) } } }
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible())], spacing: 16) { ForEach(filtered) { PersonGridCard(person: $0) } }
                }.padding(18).padding(.bottom, 20)
            }
        }.toolbar(.hidden, for: .navigationBar).foregroundStyle(.white)
    }
}

private struct PersonGridCard: View {
    let person: CommunityPerson
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 25, style: .continuous).fill(LinearGradient(colors: [Color.appPurple.opacity(0.7), Color.appPink.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)).aspectRatio(0.8, contentMode: .fit).overlay(Image(systemName: person.symbol).font(.system(size: 54)).foregroundStyle(.white.opacity(0.9)))
                if person.online { Text("ONLINE").font(.caption2.bold()).padding(.horizontal, 8).padding(.vertical, 5).background(.green, in: Capsule()).padding(10) }
            }
            HStack(spacing: 4) { Text("\(person.name), \(person.age)").font(.headline); if person.verified { Image(systemName: "checkmark.seal.fill").font(.caption).foregroundStyle(Color.appCyan) } }
            Text(person.headline).font(.caption).foregroundStyle(.secondary).lineLimit(1)
            Label(person.distance, systemImage: "location.fill").font(.caption2).foregroundStyle(.secondary)
        }
    }
}
