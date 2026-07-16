import SwiftUI

struct WelcomeView: View {
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome = false
    @State private var page = 0

    private let slides = [
        ("mappin.and.ellipse", "La tua città, più vicina", "Scopri luoghi LGBTQ+, eventi e persone intorno a te."),
        ("person.2.crop.square.stack.fill", "Conosci la community", "Trova nuove amicizie e persone con interessi simili."),
        ("hand.raised.fill", "Posizione sotto controllo", "Decidi tu quando mostrarti. Mai coordinate precise agli altri.")
    ]

    var body: some View {
        ZStack {
            AppBackground()
            VStack(spacing: 24) {
                HStack {
                    BrandMark(size: 48)
                    Text("QSpot").font(.title2.bold())
                    Spacer()
                    if page < slides.count - 1 {
                        Button("Salta") { hasSeenWelcome = true }.foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)

                TabView(selection: $page) {
                    ForEach(slides.indices, id: \.self) { index in
                        VStack(spacing: 34) {
                            Spacer()
                            ZStack {
                                Circle().fill(LinearGradient(colors: [Color.appPurple, Color.appPink], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 210, height: 210).blur(radius: 1)
                                Image(systemName: slides[index].0).font(.system(size: 78, weight: .semibold)).foregroundStyle(.white)
                            }
                            VStack(spacing: 14) {
                                Text(slides[index].1).font(.system(size: 34, weight: .bold, design: .rounded)).multilineTextAlignment(.center)
                                Text(slides[index].2).font(.title3).foregroundStyle(.secondary).multilineTextAlignment(.center).padding(.horizontal, 20)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))

                Button {
                    if page < slides.count - 1 { withAnimation { page += 1 } } else { hasSeenWelcome = true }
                } label: {
                    HStack { Text(page == slides.count - 1 ? "Inizia" : "Continua"); Image(systemName: "arrow.right") }
                        .font(.headline).frame(maxWidth: .infinity).padding(.vertical, 17)
                        .background(LinearGradient(colors: [Color.appPurple, Color.appPink], startPoint: .leading, endPoint: .trailing), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 24).padding(.bottom, 22)
            }
            .foregroundStyle(.white)
        }
    }
}

struct BrandMark: View {
    var size: CGFloat = 42
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.29, style: .continuous).fill(LinearGradient(colors: [Color.appPurple, Color.appPink], startPoint: .topLeading, endPoint: .bottomTrailing))
            Image(systemName: "mappin.and.ellipse").font(.system(size: size * 0.45, weight: .bold)).foregroundStyle(.white)
        }.frame(width: size, height: size)
    }
}
