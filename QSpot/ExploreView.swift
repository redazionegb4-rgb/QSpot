import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""

    var filtered: [PersonProfile] {
        searchText.isEmpty ? DemoData.people : DemoData.people.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(filtered) { person in
                    NavigationLink(value: person) {
                        PersonCard(person: person)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .searchable(text: $searchText, prompt: "Cerca persone")
        .navigationTitle("Persone vicine")
        .navigationDestination(for: PersonProfile.self) { person in
            PersonDetailView(person: person)
        }
    }
}

private struct PersonCard: View {
    let person: PersonProfile
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 24)
                    .fill(LinearGradient(colors: [Color.qPink.opacity(0.7), Color.qPurple.opacity(0.75)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .aspectRatio(0.82, contentMode: .fit)
                    .overlay(Image(systemName: person.symbol).font(.system(size: 56)).foregroundStyle(.white.opacity(0.9)))
                if person.isOnline {
                    Text("ONLINE")
                        .font(.caption2.bold())
                        .padding(.horizontal, 8).padding(.vertical, 5)
                        .background(.green, in: Capsule())
                        .foregroundStyle(.white)
                        .padding(10)
                }
            }
            Text("\(person.name), \(person.age)").font(.headline)
            Label(person.distance, systemImage: "location.fill").font(.caption).foregroundStyle(.secondary)
        }
    }
}

struct PersonDetailView: View {
    let person: PersonProfile
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 28)
                    .fill(LinearGradient(colors: [Color.qPurple, Color.qPink], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(height: 390)
                    .overlay(Image(systemName: person.symbol).font(.system(size: 92)).foregroundStyle(.white.opacity(0.95)))

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("\(person.name), \(person.age)").font(.largeTitle.bold())
                        Spacer()
                        Circle().fill(person.isOnline ? .green : .gray).frame(width: 12, height: 12)
                    }
                    Label("\(person.city) · \(person.distance)", systemImage: "location.fill")
                        .foregroundStyle(.secondary)
                    Text(person.bio).font(.title3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 14) {
                    Button(action: {}) { Label("Mi piace", systemImage: "heart.fill").frame(maxWidth: .infinity).padding() }
                        .buttonStyle(.borderedProminent).tint(Color.qPink)
                    Button(action: {}) { Label("Messaggio", systemImage: "bubble.left.fill").frame(maxWidth: .infinity).padding() }
                        .buttonStyle(.borderedProminent).tint(Color.qPurple)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
