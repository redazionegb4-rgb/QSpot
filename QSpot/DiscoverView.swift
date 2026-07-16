import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing:18) {
                    header
                    featured
                    quickGrid
                    suggestions
                }
                .padding(.horizontal,14).padding(.top,10).padding(.bottom,20)
            }
            .background(Theme.bg)
            .navigationDestination(for:Person.self){PersonDetailView(person:$0)}
            .toolbar(.hidden,for:.navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName:"line.3.horizontal").font(.title3)
            Text("Qspot").font(.system(size:24,weight:.bold,design:.rounded))
            Spacer()
            Image(systemName:"slider.horizontal.3").font(.title3)
        }
    }

    private var featured: some View {
        let p=store.people[0]
        return NavigationLink(value:p) {
            ZStack(alignment:.bottomLeading) {
                Image("hero1").resizable().scaledToFill().frame(height:540).clipped()
                LinearGradient(colors:[.clear,.black.opacity(0.10),.black.opacity(0.95)],startPoint:.top,endPoint:.bottom)
                VStack(alignment:.leading,spacing:10) {
                    HStack(spacing:7) {
                        Text("\(p.name), \(p.age)").font(.system(size:31,weight:.black))
                        if p.verified { Image(systemName:"checkmark.seal.fill").foregroundStyle(Theme.lilac) }
                    }
                    HStack(spacing:7) {
                        Circle().fill(Theme.green).frame(width:8,height:8)
                        Text("Online ora")
                        Text("•")
                        Image(systemName:"location.fill")
                        Text(p.distance)
                    }.font(.subheadline).foregroundStyle(.white.opacity(0.78))
                    HStack(spacing:8) {
                        ForEach(p.interests,id:\.self) { x in
                            Text(x).font(.caption.weight(.semibold)).padding(.horizontal,10).frame(height:30).background(.black.opacity(0.38)).clipShape(Capsule())
                        }
                    }
                }.padding(18)
                VStack { Spacer(); HStack { Spacer(); VStack(spacing:12) { round("heart.fill",Theme.pink); round("bubble.left.fill",Theme.lilac); round("star.fill",.white) } } }.padding(16)
            }
            .frame(height:540).clipShape(RoundedRectangle(cornerRadius:28,style:.continuous))
        }.buttonStyle(.plain)
    }

    private func round(_ icon:String,_ color:Color)->some View {
        Image(systemName:icon).font(.title3.bold()).foregroundStyle(color).frame(width:48,height:48).background(.black.opacity(0.42)).clipShape(Circle()).overlay(Circle().stroke(Color.white.opacity(0.10)))
    }

    private var quickGrid: some View {
        VStack(alignment:.leading,spacing:12) {
            Text("Cosa stai cercando oggi?").font(.title3.bold())
            HStack(spacing:10) { QuickCard(title:"Vicino a te",icon:"location.fill",color:.purple); QuickCard(title:"Online ora",icon:"circle.fill",color:.green) }
            HStack(spacing:10) { QuickCard(title:"Nuovi",icon:"star.fill",color:.blue); QuickCard(title:"Più attivi",icon:"flame.fill",color:.orange) }
        }
    }

    private var suggestions: some View {
        VStack(alignment:.leading,spacing:12) {
            HStack { Text("Suggeriti per te").font(.title3.bold()); Spacer(); Text("Vedi tutti").font(.subheadline.weight(.semibold)).foregroundStyle(Theme.lilac) }
            ScrollView(.horizontal,showsIndicators:false) {
                HStack(spacing:10) {
                    ForEach(store.people.dropFirst()) { p in NavigationLink(value:p){SuggestedCard(person:p)}.buttonStyle(.plain) }
                }
            }
        }
    }
}

struct QuickCard: View {
    let title:String; let icon:String; let color:Color
    var body: some View {
        VStack(alignment:.leading,spacing:16) {
            ZStack { Circle().fill(color.opacity(0.18)).frame(width:42,height:42); Image(systemName:icon).foregroundStyle(color) }
            Text(title).font(.headline)
            HStack(spacing:-5) { ForEach(0..<4,id:\.self){_ in Circle().fill(Color.white.opacity(0.20)).frame(width:24,height:24).overlay(Circle().stroke(Theme.panel,lineWidth:2))} }
        }
        .frame(maxWidth:.infinity,alignment:.leading).padding(16).background(Theme.panel).clipShape(RoundedRectangle(cornerRadius:20,style:.continuous))
    }
}

struct SuggestedCard: View {
    let person:Person
    var body: some View {
        ZStack(alignment:.bottomLeading) {
            Image(person.image).resizable().scaledToFill().frame(width:165,height:220).clipped()
            LinearGradient(colors:[.clear,.black.opacity(0.88)],startPoint:.top,endPoint:.bottom)
            VStack(alignment:.leading,spacing:4) {
                Text("\(person.name), \(person.age)").font(.headline.bold())
                HStack(spacing:5){Circle().fill(person.online ? Theme.green : .gray).frame(width:7,height:7);Text(person.distance).font(.caption2)}
            }.padding(11)
        }.frame(width:165,height:220).clipShape(RoundedRectangle(cornerRadius:17,style:.continuous))
    }
}
