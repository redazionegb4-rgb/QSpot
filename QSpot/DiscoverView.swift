import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    topBar
                    searchBar
                    filters

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 7),
                            GridItem(.flexible(), spacing: 7),
                            GridItem(.flexible(), spacing: 7)
                        ],
                        spacing: 7
                    ) {
                        ForEach(store.filtered) { person in
                            NavigationLink(value: person) {
                                CompactPersonCard(person: person)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 18)
            }
            .background(Theme.bg)
            .navigationDestination(for: Person.self) {
                PersonDetailView(person: $0)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var topBar: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Theme.accent)
                    .frame(width: 34, height: 34)
                Text("Q")
                    .font(.system(size: 18, weight: .black, design: .rounded))
                    .foregroundStyle(.black)
            }

            VStack(alignment: .leading, spacing: 1) {
                Text("QSPOT")
                    .font(.system(size: 24, weight: .black, design: .rounded))
                Text("Persone vicino a te")
                    .font(.caption)
                    .foregroundStyle(Theme.secondaryText)
            }

            Spacer()

            Button {} label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(width: 38, height: 38)
                    .background(Theme.accent)
                    .clipShape(Circle())
            }
        }
    }

    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Theme.secondaryText)
            TextField("Cerca un profilo", text: $store.query)
                .textInputAutocapitalization(.never)
        }
        .padding(.horizontal, 14)
        .frame(height: 44)
        .background(Theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private var filters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(["Tutti", "Online", "Verificati", "Vicini"], id: \.self) { item in
                    Button {
                        withAnimation(.easeOut(duration: 0.18)) {
                            store.filter = item
                        }
                    } label: {
                        HStack(spacing: 6) {
                            if item == "Online" {
                                Circle().fill(.green).frame(width: 7, height: 7)
                            }
                            Text(item)
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(store.filter == item ? .black : .white)
                        .padding(.horizontal, 14)
                        .frame(height: 34)
                        .background(store.filter == item ? Theme.accent : Theme.surface)
                        .clipShape(Capsule())
                    }
                }
            }
        }
    }
}

struct CompactPersonCard: View {
    let person: Person

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(person.image)
                .resizable()
                .scaledToFill()
                .frame(height: 178)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.05), .black.opacity(0.92)],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 4) {
                    Text(person.name)
                        .font(.subheadline.bold())
                    Text("\(person.age)")
                        .font(.subheadline)
                    if person.verified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.caption2)
                            .foregroundStyle(Theme.accent)
                    }
                }

                HStack(spacing: 5) {
                    Circle()
                        .fill(person.online ? Color.green : Color.gray)
                        .frame(width: 6, height: 6)
                    Text(person.distance)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(.white.opacity(0.72))
                }
            }
            .padding(9)
        }
        .frame(height: 178)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
