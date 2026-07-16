import SwiftUI

struct ProfileView: View {
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome = true
    @State private var travelMode = false

    var body: some View {
        ZStack {
            AppBackground()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    HStack { Text("Profilo").font(.system(size: 34, weight: .bold, design: .rounded)); Spacer(); Button(action: {}) { Image(systemName: "gearshape.fill").frame(width: 44, height: 44).glassCard(radius: 15) } }
                    ZStack(alignment: .bottomTrailing) {
                        Circle().fill(LinearGradient(colors: [Color.appPurple, Color.appPink], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 126, height: 126).overlay(Image(systemName: "person.fill").font(.system(size: 54)).foregroundStyle(.white))
                        Image(systemName: "camera.fill").padding(10).background(.white, in: Circle()).foregroundStyle(Color.appPurple)
                    }
                    VStack(spacing: 5) { HStack { Text("Il tuo profilo").font(.title2.bold()); Image(systemName: "checkmark.seal.fill").foregroundStyle(Color.appCyan) }; Text("Completa il profilo per farti conoscere").foregroundStyle(.secondary) }
                    HStack(spacing: 10) { ProfileMetric(value: "0", label: "Like"); ProfileMetric(value: "0", label: "Match"); ProfileMetric(value: "3", label: "Preferiti") }
                    VStack(spacing: 0) {
                        ProfileRow(icon: "person.text.rectangle", title: "Modifica profilo", subtitle: "Foto, bio e interessi")
                        Divider().overlay(.white.opacity(0.08))
                        ProfileRow(icon: "slider.horizontal.3", title: "Preferenze", subtitle: "Chi vuoi conoscere")
                        Divider().overlay(.white.opacity(0.08))
                        Toggle(isOn: $travelMode) { Label("Modalità viaggio", systemImage: "airplane") }.padding(16)
                        Divider().overlay(.white.opacity(0.08))
                        ProfileRow(icon: "shield.checkered", title: "Privacy e sicurezza", subtitle: "Posizione, blocchi e segnalazioni")
                    }.glassCard(radius: 24)
                    Button("Mostra di nuovo la presentazione") { hasSeenWelcome = false }.font(.subheadline).foregroundStyle(.secondary)
                }.padding(18)
            }
        }.toolbar(.hidden, for: .navigationBar).foregroundStyle(.white)
    }
}

private struct ProfileMetric: View {
    let value: String; let label: String
    var body: some View { VStack(spacing: 3) { Text(value).font(.title2.bold()); Text(label).font(.caption).foregroundStyle(.secondary) }.frame(maxWidth: .infinity).padding(.vertical, 15).glassCard(radius: 18) }
}
private struct ProfileRow: View {
    let icon: String; let title: String; let subtitle: String
    var body: some View { HStack(spacing: 13) { Image(systemName: icon).font(.title3).foregroundStyle(Color.appCyan).frame(width: 28); VStack(alignment: .leading, spacing: 3) { Text(title).font(.headline); Text(subtitle).font(.caption).foregroundStyle(.secondary) }; Spacer(); Image(systemName: "chevron.right").foregroundStyle(.secondary) }.padding(16) }
}
