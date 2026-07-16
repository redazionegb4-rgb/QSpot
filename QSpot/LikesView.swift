import SwiftUI

struct LikesView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        ScrollView {
            VStack(alignment:.leading,spacing:18) {
                HStack { Text("I tuoi like").font(.system(size:29,weight:.bold)); Spacer(); Text("Vedi tutti").foregroundStyle(Theme.lilac) }
                ZStack {
                    RoundedRectangle(cornerRadius:26).fill(RadialGradient(colors:[Theme.purple.opacity(0.34),Theme.panel],center:.center,startRadius:10,endRadius:170)).frame(height:190)
                    VStack(spacing:8){Image(systemName:"heart.fill").font(.system(size:64)).foregroundStyle(Theme.pink);Text("23").font(.system(size:38,weight:.black))}
                }
                ForEach(store.people.prefix(4)) { p in
                    HStack(spacing:12) {
                        Image(p.image).resizable().scaledToFill().frame(width:56,height:56).clipShape(Circle())
                        VStack(alignment:.leading,spacing:4){Text("\(p.name), \(p.age)").font(.headline);Text(p.distance).font(.subheadline).foregroundStyle(Theme.secondary)}
                        Spacer();Image(systemName:"bubble.left.fill").foregroundStyle(Theme.lilac).frame(width:42,height:42).background(Theme.panel).clipShape(Circle())
                    }.padding(12).background(Theme.panel).clipShape(RoundedRectangle(cornerRadius:17,style:.continuous))
                }
            }.padding(.horizontal,14).padding(.top,10).padding(.bottom,18)
        }.background(Theme.bg)
    }
}
