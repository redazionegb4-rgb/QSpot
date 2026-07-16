import SwiftUI

struct ChatsView: View {
    @EnvironmentObject var store: AppStore
    var body: some View {
        ScrollView {
            VStack(alignment:.leading,spacing:14) {
                HStack { Text("Chat").font(.system(size:29,weight:.bold)); Spacer(); Image(systemName:"square.and.pencil").foregroundStyle(Theme.lilac) }
                HStack { Image(systemName:"magnifyingglass"); TextField("Cerca",text:$store.query) }.padding(.horizontal,13).frame(height:42).background(Theme.panel).clipShape(RoundedRectangle(cornerRadius:14))
                ScrollView(.horizontal,showsIndicators:false) {
                    HStack(spacing:13) { ForEach(store.people.prefix(4)) { p in VStack(spacing:6){Image(p.image).resizable().scaledToFill().frame(width:58,height:58).clipShape(Circle()).overlay(Circle().stroke(Theme.lilac,lineWidth:2));Text(p.name).font(.caption2)} } }
                }
                ForEach(store.chats) { c in
                    HStack(spacing:12) {
                        ZStack(alignment:.bottomTrailing){Image(c.person.image).resizable().scaledToFill().frame(width:56,height:56).clipShape(Circle());if c.person.online{Circle().fill(Theme.green).frame(width:13,height:13).overlay(Circle().stroke(Theme.bg,lineWidth:2))}}
                        VStack(alignment:.leading,spacing:4){Text(c.person.name).font(.headline);Text(c.preview).font(.subheadline).foregroundStyle(Theme.secondary)}
                        Spacer();VStack(alignment:.trailing,spacing:7){Text(c.time).font(.caption2).foregroundStyle(Theme.secondary);if c.unread>0{Text("\(c.unread)").font(.caption2.bold()).frame(width:22,height:22).background(Theme.purple).clipShape(Circle())}}
                    }.padding(.vertical,10)
                    Divider().overlay(Theme.line)
                }
            }.padding(.horizontal,14).padding(.top,10).padding(.bottom,18)
        }.background(Theme.bg)
    }
}
