import SwiftUI

struct ProfileView: View {
    @AppStorage("displayName") private var displayName = "Il tuo profilo"
    @AppStorage("profileBio") private var profileBio = "Racconta qualcosa di te..."
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = true
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Form {
            Section {
                HStack(spacing: 16) {
                    Circle()
                        .fill(LinearGradient(colors: [Color.qPurple, Color.qPink], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 74, height: 74)
                        .overlay(Image(systemName: "person.fill").font(.largeTitle).foregroundStyle(.white))
                    VStack(alignment: .leading) {
                        TextField("Nome", text: $displayName).font(.title3.bold())
                        Text("Profilo locale demo").foregroundStyle(.secondary)
                    }
                }
            }

            Section("Descrizione") {
                TextField("Bio", text: $profileBio, axis: .vertical)
                    .lineLimit(3...6)
            }

            Section("Preferenze") {
                Label("Posizione approssimativa", systemImage: "location.circle.fill")
                Label("Solo maggiorenni", systemImage: "18.circle.fill")
                Label(colorScheme == .dark ? "Tema scuro attivo" : "Tema chiaro attivo", systemImage: "circle.lefthalf.filled")
            }

            Section("Prossimamente") {
                Label("Account Supabase", systemImage: "person.badge.key.fill")
                Label("Caricamento fotografie", systemImage: "photo.fill")
                Label("Chat e notifiche", systemImage: "bubble.left.and.bubble.right.fill")
                Label("Blocchi e segnalazioni", systemImage: "shield.fill")
            }

            Section {
                Button("Rivedi introduzione") { hasCompletedOnboarding = false }
                    .foregroundStyle(Color.qPurple)
            }
        }
        .navigationTitle("Profilo")
    }
}
