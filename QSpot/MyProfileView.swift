import SwiftUI

struct MyProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {
                        VStack(spacing: 12) {
                            Circle()
                                .fill(AppTheme.gradient)
                                .frame(width: 112, height: 112)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 48))
                                )

                            Text("Il tuo profilo")
                                .font(.title2.bold())
                            Text("Completa il profilo per ricevere più interazioni.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)

                            Button("Modifica profilo") {}
                                .font(.headline.bold())
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(AppTheme.gradient)
                                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        }
                        .padding(20)
                        .glassCard()

                        settings
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Profilo")
        }
    }

    private var settings: some View {
        VStack(spacing: 0) {
            SettingRow(icon: "slider.horizontal.3", title: "Preferenze incontri")
            Divider().opacity(0.2)
            SettingRow(icon: "location.fill", title: "Distanza e posizione")
            Divider().opacity(0.2)
            SettingRow(icon: "shield.fill", title: "Privacy e sicurezza")
            Divider().opacity(0.2)
            SettingRow(icon: "bell.fill", title: "Notifiche")
            Divider().opacity(0.2)
            SettingRow(icon: "questionmark.circle.fill", title: "Assistenza")
        }
        .padding(.horizontal, 16)
        .glassCard()
    }
}

struct SettingRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .frame(width: 28)
                .foregroundStyle(AppTheme.cyan)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 16)
    }
}
