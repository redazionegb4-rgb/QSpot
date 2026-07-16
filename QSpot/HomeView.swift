import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            AppBackground()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    header
                    hero
                    peopleSection
                    placesSection
                    eventsSection
                }
                .padding(.horizontal, 18).padding(.bottom, 28)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .foregroundStyle(.white)
    }

    private var header: some View {
        HStack(spacing: 13) {
            BrandMark(size: 46)
            VStack(alignment: .leading, spacing: 2) {
                Text("Buonasera").font(.caption).foregroundStyle(.secondary)
                HStack(spacing: 5) { Text("Roma").font(.title2.bold()); Image(systemName: "chevron.down").font(.caption.bold()) }
            }
            Spacer()
            Button(action: {}) { Image(systemName: "bell.fill").frame(width: 44, height: 44).glassCard(radius: 15) }
        }.padding(.top, 14)
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Label("INTORNO A TE", systemImage: "location.fill").font(.caption.bold()).foregroundStyle(.white.opacity(0.8))
                Spacer()
                Text("LIVE").font(.caption2.bold()).padding(.horizontal, 9).padding(.vertical, 5).background(.green, in: Capsule())
            }
            Text("La community è\npiù vicina stasera.").font(.system(size: 32, weight: .bold, design: .rounded))
            HStack(spacing: 10) {
                Metric(value: "18", label: "persone")
                Metric(value: "12", label: "luoghi")
                Metric(value: "4", label: "eventi")
            }
            Button(action: {}) {
                Label("Esplora adesso", systemImage: "sparkles")
                    .font(.headline).padding(.horizontal, 18).padding(.vertical, 13)
                    .background(.white, in: Capsule()).foregroundStyle(Color.appBackground)
            }
        }
        .padding(22)
        .background(LinearGradient(colors: [.appPurple, .appPink], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay(alignment: .topTrailing) { Circle().stroke(.white.opacity(0.18), lineWidth: 36).frame(width: 180).offset(x: 70, y: -65) }
        .clipped().shadow(color: .appPurple.opacity(0.28), radius: 22, y: 12)
    }

    private var peopleSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitle(title: "Persone vicine", action: "Vedi tutte")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 13) { ForEach(DemoContent.people) { PersonMiniCard(person: $0) } }
            }.contentMargins(.horizontal, 1, for: .scrollContent)
        }
    }

    private var placesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitle(title: "Posti per te", action: "Apri mappa")
            ForEach(DemoContent.places.prefix(3)) { place in NavigationLink(value: place) { PlaceRow(place: place) }.buttonStyle(.plain) }
        }.navigationDestination(for: CommunityPlace.self) { PlaceDetailView(place: $0) }
    }

    private var eventsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitle(title: "Prossimi eventi", action: "Calendario")
            ForEach(DemoContent.events.prefix(2)) { EventRow(event: $0) }
        }
    }
}

private struct Metric: View {
    let value: String; let label: String
    var body: some View { VStack(alignment: .leading, spacing: 1) { Text(value).font(.title2.bold()); Text(label).font(.caption).foregroundStyle(.white.opacity(0.75)) }.frame(maxWidth: .infinity, alignment: .leading) }
}

struct SectionTitle: View {
    let title: String; let action: String
    var body: some View { HStack { Text(title).font(.title2.bold()); Spacer(); Text(action).font(.subheadline.bold()).foregroundStyle(.appCyan) } }
}

struct PersonMiniCard: View {
    let person: CommunityPerson
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(LinearGradient(colors: [.appPurple.opacity(0.75), .appPink.opacity(0.78)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 150, height: 184)
                    .overlay(Image(systemName: person.symbol).font(.system(size: 58, weight: .medium)).foregroundStyle(.white.opacity(0.92)))
                if person.online { Circle().fill(.green).frame(width: 14, height: 14).overlay(Circle().stroke(.white, lineWidth: 3)).padding(12) }
            }
            HStack(spacing: 5) { Text("\(person.name), \(person.age)").font(.headline); if person.verified { Image(systemName: "checkmark.seal.fill").font(.caption).foregroundStyle(.appCyan) } }
            Text(person.distance).font(.caption).foregroundStyle(.secondary)
        }.frame(width: 150, alignment: .leading)
    }
}

struct PlaceRow: View {
    let place: CommunityPlace
    var body: some View {
        HStack(spacing: 14) {
            ZStack { RoundedRectangle(cornerRadius: 17).fill(Color.appPurple.opacity(0.2)); Image(systemName: place.symbol).font(.title2).foregroundStyle(.appCyan) }.frame(width: 58, height: 58)
            VStack(alignment: .leading, spacing: 5) {
                Text(place.name).font(.headline)
                Text("\(place.category) · \(place.neighborhood)").font(.caption).foregroundStyle(.secondary).lineLimit(1)
                HStack(spacing: 5) { Image(systemName: "star.fill").foregroundStyle(.yellow); Text(String(format: "%.1f", place.rating)); Text("· \(place.distance)").foregroundStyle(.secondary) }.font(.caption)
            }
            Spacer()
            Text(place.isOpen ? "APERTO" : "CHIUSO").font(.caption2.bold()).foregroundStyle(place.isOpen ? .green : .secondary)
        }.padding(14).glassCard(radius: 22)
    }
}

struct EventRow: View {
    let event: CommunityEvent
    var body: some View {
        HStack(spacing: 14) {
            VStack(spacing: 2) { Text(event.day).font(.caption2.bold()).foregroundStyle(.appPink); Text(event.time).font(.headline) }.frame(width: 66)
            Divider().overlay(.white.opacity(0.12)).frame(height: 48)
            Image(systemName: event.symbol).font(.title2).foregroundStyle(.appPurple).frame(width: 30)
            VStack(alignment: .leading, spacing: 4) { Text(event.title).font(.headline); Text(event.venue).font(.caption).foregroundStyle(.secondary) }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(.secondary)
        }.padding(14).glassCard(radius: 22)
    }
}
