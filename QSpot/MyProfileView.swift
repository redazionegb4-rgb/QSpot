import SwiftUI

struct MyProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    HStack {
                        Text("Profilo")
                            .font(.system(size: 29, weight: .bold))
                        Spacer()
                        Button {} label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundStyle(QTheme.blue)
                                .font(.title3)
                        }
                    }

                    VStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .fill(QTheme.accentGradient)
                                .frame(width: 108, height: 108)
                            Image(systemName: "person.fill")
                                .font(.system(size: 42))
                                .foregroundStyle(.white)
                        }

                        Text("Il tuo profilo")
                            .font(.title2.bold())
                        Text("Completa il profilo per ricevere più interazioni.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)

                        Button {} label: {
                            Text("Modifica profilo")
                                .font(.headline.bold())
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(QTheme.accentGradient)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        }
                    }
                    .padding(20)
                    .qPanel()

                    VStack(spacing: 0) {
                        ProfileSetting(icon: "slider.horizontal.3", title: "Preferenze incontri")
                        ProfileSetting(icon: "location.fill", title: "Distanza e posizione")
                        ProfileSetting(icon: "shield.fill", title: "Privacy e sicurezza")
                        ProfileSetting(icon: "bell.fill", title: "Notifiche")
                        ProfileSetting(icon: "questionmark.circle.fill", title: "Assistenza")
                    }
                    .padding(.horizontal, 16)
                    .qPanel()
                }
                .padding(.horizontal, 14)
                .padding(.top, 10)
                .padding(.bottom, 18)
            }
            .background(QTheme.background)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct ProfileSetting: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: icon)
                .foregroundStyle(QTheme.cyan)
                .frame(width: 25)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 16)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.white.opacity(0.05)).frame(height: 1)
        }
    }
}
