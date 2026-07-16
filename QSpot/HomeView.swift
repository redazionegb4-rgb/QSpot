import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Buonasera")
                            .foregroundStyle(.secondary)
                        Text("Roma")
                            .font(.largeTitle.bold())
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "bell.fill")
                            .font(.title3)
                            .padding(12)
                            .background(.thinMaterial, in: Circle())
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Label("Vicino a te adesso", systemImage: "location.fill")
                        .font(.headline)
                    Text("Scopri persone, locali ed eventi della community nella tua zona.")
                        .font(.title3.weight(.semibold))
                    HStack {
                        StatBubble(value: "16", label: "Persone")
                        StatBubble(value: "8", label: "Luoghi")
                        StatBubble(value: "3", label: "Eventi")
                    }
                }
                .gradientCard()

                SectionHeader(title: "Persone online", action: "Vedi tutte")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(DemoData.people.prefix(4)) { person in
                            MiniPersonCard(person: person)
                        }
                    }
                }

                SectionHeader(title: "Posti consigliati", action: "Mappa")
                VStack(spacing: 12) {
                    ForEach(DemoData.places.prefix(3)) { place in
                        NavigationLink(value: place) {
                            PlaceRow(place: place)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
        .navigationDestination(for: QueerPlace.self) { place in
            PlaceDetailView(place: place)
        }
        .navigationTitle("QSpot")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct StatBubble: View {
    let value: String
    let label: String
    var body: some View {
        VStack(spacing: 2) {
            Text(value).font(.title2.bold())
            Text(label).font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(.white.opacity(0.16), in: RoundedRectangle(cornerRadius: 14))
    }
}

struct SectionHeader: View {
    let title: String
    let action: String
    var body: some View {
        HStack {
            Text(title).font(.title2.bold())
            Spacer()
            Text(action).font(.subheadline.weight(.semibold)).foregroundStyle(Color.qPurple)
        }
    }
}

private struct MiniPersonCard: View {
    let person: PersonProfile
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [Color.qPurple.opacity(0.7), Color.qBlue.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 145, height: 165)
                    .overlay(Image(systemName: person.symbol).font(.system(size: 56)).foregroundStyle(.white.opacity(0.9)))
                if person.isOnline {
                    Circle().fill(.green).frame(width: 14, height: 14).overlay(Circle().stroke(.white, lineWidth: 2)).padding(10)
                }
            }
            Text("\(person.name), \(person.age)").font(.headline)
            Text(person.distance).font(.caption).foregroundStyle(.secondary)
        }
        .frame(width: 145)
    }
}
