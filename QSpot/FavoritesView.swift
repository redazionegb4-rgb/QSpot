import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var store: AppStore

    private var saved: [Person] {
        store.people.filter { store.favorites.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text("Preferiti")
                        .font(.system(size: 29, weight: .bold))
                        .padding(.top, 10)

                    if saved.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "star")
                                .font(.system(size: 42))
                                .foregroundStyle(Theme.accent)
                            Text("Nessun preferito")
                                .font(.title3.bold())
                            Text("Salva i profili che vuoi ritrovare rapidamente.")
                                .font(.subheadline)
                                .foregroundStyle(Theme.secondaryText)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 120)
                    } else {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 7),
                                GridItem(.flexible(), spacing: 7),
                                GridItem(.flexible(), spacing: 7)
                            ],
                            spacing: 7
                        ) {
                            ForEach(saved) { person in
                                NavigationLink(value: person) {
                                    CompactPersonCard(person: person)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 18)
            }
            .background(Theme.bg)
            .navigationDestination(for: Person.self) {
                PersonDetailView(person: $0)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
