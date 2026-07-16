import SwiftUI

struct ProfileView: View {
    @State private var showEdit = false
    @State private var showPreferences = false
    @State private var showPrivacy = false
    @State private var showNotifications = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    header
                    profileCard
                    settingsSection
                    accountSection
                }
                .padding(.horizontal, 14)
                .padding(.top, 10)
                .padding(.bottom, 18)
            }
            .background(Theme.bg)
            .navigationDestination(isPresented: $showEdit) { EditProfileView() }
            .navigationDestination(isPresented: $showPreferences) { PreferencesView() }
            .navigationDestination(isPresented: $showPrivacy) { PrivacyView() }
            .navigationDestination(isPresented: $showNotifications) { NotificationsView() }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Text("Profilo")
                .font(.system(size: 29, weight: .bold))
            Spacer()
            Image(systemName: "gearshape.fill")
                .foregroundStyle(Theme.accent)
        }
    }

    private var profileCard: some View {
        VStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Theme.accent)
                    .frame(width: 96, height: 96)
                Image(systemName: "person.fill")
                    .font(.system(size: 38))
                    .foregroundStyle(.black)
            }

            Text("Il tuo profilo")
                .font(.title2.bold())

            Text("Aggiungi foto e informazioni per rendere il profilo più completo.")
                .font(.subheadline)
                .foregroundStyle(Theme.secondaryText)
                .multilineTextAlignment(.center)

            Button {
                showEdit = true
            } label: {
                Text("Modifica profilo")
                    .font(.headline.bold())
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Theme.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
        }
        .padding(18)
        .background(Theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private var settingsSection: some View {
        VStack(spacing: 0) {
            settingsRow("slider.horizontal.3", "Preferenze incontri") { showPreferences = true }
            settingsRow("shield.fill", "Privacy e sicurezza") { showPrivacy = true }
            settingsRow("bell.fill", "Notifiche") { showNotifications = true }
            settingsRow("location.fill", "Distanza e posizione") {}
        }
        .padding(.horizontal, 15)
        .background(Theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private var accountSection: some View {
        VStack(spacing: 0) {
            settingsRow("questionmark.circle.fill", "Assistenza") {}
            settingsRow("doc.text.fill", "Termini e privacy") {}
            settingsRow("rectangle.portrait.and.arrow.right", "Esci") {}
        }
        .padding(.horizontal, 15)
        .background(Theme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private func settingsRow(_ icon: String, _ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 13) {
                Image(systemName: icon)
                    .foregroundStyle(Theme.accent)
                    .frame(width: 25)
                Text(title)
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Theme.secondaryText)
            }
            .padding(.vertical, 16)
        }
        .overlay(alignment: .bottom) {
            Rectangle().fill(Theme.divider).frame(height: 1)
        }
    }
}

struct EditProfileView: View {
    @State private var name = ""
    @State private var bio = ""
    @State private var age = 18

    var body: some View {
        Form {
            Section("Foto") {
                HStack {
                    Spacer()
                    Circle()
                        .fill(Theme.accent)
                        .frame(width: 110, height: 110)
                        .overlay(Image(systemName: "camera.fill").foregroundStyle(.black))
                    Spacer()
                }
            }
            Section("Informazioni") {
                TextField("Nome", text: $name)
                Stepper("Età: \(age)", value: $age, in: 18...99)
                TextField("Descrizione", text: $bio, axis: .vertical)
            }
        }
        .navigationTitle("Modifica profilo")
    }
}

struct PreferencesView: View {
    @State private var maxDistance = 25.0
    @State private var minAge = 18.0
    @State private var maxAge = 45.0

    var body: some View {
        Form {
            Section("Distanza") {
                Slider(value: $maxDistance, in: 1...100, step: 1)
                Text("Fino a \(Int(maxDistance)) km")
            }
            Section("Età") {
                Slider(value: $minAge, in: 18...70, step: 1)
                Slider(value: $maxAge, in: 18...99, step: 1)
                Text("\(Int(minAge)) – \(Int(maxAge)) anni")
            }
        }
        .navigationTitle("Preferenze")
    }
}

struct PrivacyView: View {
    @State private var hideDistance = false
    @State private var showOnline = true
    @State private var privatePhotos = false

    var body: some View {
        Form {
            Toggle("Mostra stato online", isOn: $showOnline)
            Toggle("Nascondi distanza", isOn: $hideDistance)
            Toggle("Foto private", isOn: $privatePhotos)
            Section("Sicurezza") {
                Label("Utenti bloccati", systemImage: "person.crop.circle.badge.xmark")
                Label("Segnalazioni", systemImage: "exclamationmark.shield")
            }
        }
        .navigationTitle("Privacy")
    }
}

struct NotificationsView: View {
    @State private var messages = true
    @State private var favorites = true
    @State private var nearby = false

    var body: some View {
        Form {
            Toggle("Nuovi messaggi", isOn: $messages)
            Toggle("Nuovi preferiti", isOn: $favorites)
            Toggle("Nuove persone vicine", isOn: $nearby)
        }
        .navigationTitle("Notifiche")
    }
}
