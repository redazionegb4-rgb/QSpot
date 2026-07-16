import SwiftUI

struct EventsView: View {
    var body: some View {
        ZStack {
            AppBackground()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Eventi").font(.system(size: 34, weight: .bold, design: .rounded))
                    VStack(alignment: .leading, spacing: 15) {
                        Text("QUESTA SERA").font(.caption.bold()).foregroundStyle(.white.opacity(0.75))
                        Text("Esci, incontra,\nvivi la città.").font(.system(size: 31, weight: .bold, design: .rounded))
                        Text("4 eventi selezionati vicino a Roma").foregroundStyle(.white.opacity(0.8))
                    }.padding(22).frame(maxWidth: .infinity, alignment: .leading).background(LinearGradient(colors: [.appPink, .appPurple], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 30))
                    ForEach(DemoContent.events) { EventRow(event: $0) }
                }.padding(18)
            }
        }.toolbar(.hidden, for: .navigationBar).foregroundStyle(.white)
    }
}
