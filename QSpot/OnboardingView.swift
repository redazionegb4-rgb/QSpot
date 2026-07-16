import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var page = 0

    private let pages = [
        ("Trova la tua community", "Scopri persone, luoghi ed eventi LGBTQ+ vicino a te.", "location.fill"),
        ("Esplora ogni città", "Cambia città e trova locali, parchi, associazioni e serate.", "map.fill"),
        ("Privacy prima di tutto", "La posizione delle persone sarà sempre approssimativa e controllabile.", "lock.shield.fill")
    ]

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.qPurple, Color.qPink, Color.qBlue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 26) {
                Spacer()
                Image(systemName: pages[page].2)
                    .font(.system(size: 72, weight: .semibold))
                    .foregroundStyle(.white)
                    .symbolEffect(.pulse, value: page)

                Text(pages[page].0)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)

                Text(pages[page].1)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.88))
                    .padding(.horizontal, 28)

                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Capsule()
                            .fill(.white.opacity(index == page ? 1 : 0.35))
                            .frame(width: index == page ? 28 : 8, height: 8)
                    }
                }

                Spacer()

                Button {
                    if page < pages.count - 1 {
                        withAnimation(.spring) { page += 1 }
                    } else {
                        hasCompletedOnboarding = true
                    }
                } label: {
                    Text(page == pages.count - 1 ? "Inizia" : "Continua")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(.white, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .foregroundStyle(Color.qPurple)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            }
        }
    }
}
