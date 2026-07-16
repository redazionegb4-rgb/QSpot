import SwiftUI

struct PersonDetailView: View {
    @EnvironmentObject var store:AppStore
    @Environment(\.dismiss) private var dismiss
    let person:Person
    var body: some View {
        ScrollView {
            VStack(spacing:0) {
                ZStack(alignment:.bottomLeading) {
                    Image(person.hero).resizable().scaledToFill().frame(height:520).clipped()
                    LinearGradient(colors:[.black.opacity(0.10),.clear,Theme.bg],startPoint:.top,endPoint:.bottom)
                    VStack(alignment:.leading,spacing:8){HStack(spacing:7){Text("\(person.name), \(person.age)").font(.system(size:31,weight:.black));if person.verified{Image(systemName:"checkmark.seal.fill").foregroundStyle(Theme.lilac)}};HStack(spacing:7){Circle().fill(person.online ? Theme.green : .gray).frame(width:8,height:8);Text(person.distance);Text("•");Text(person.online ? "Online ora":"Offline")}.font(.subheadline).foregroundStyle(Theme.secondary)}.padding(.horizontal,18).padding(.bottom,24)
                    VStack{HStack{Button{dismiss()}label:{Image(systemName:"chevron.left").font(.title3.bold()).foregroundStyle(.white).frame(width:42,height:42).background(.black.opacity(0.42)).clipShape(Circle())};Spacer();Image(systemName:"ellipsis").font(.title3.bold()).frame(width:42,height:42).background(.black.opacity(0.42)).clipShape(Circle())};Spacer()}.padding(.horizontal,14).padding(.top,52)
                }
                VStack(alignment:.leading,spacing:18) {
                    Text(person.bio).lineSpacing(4)
                    ScrollView(.horizontal,showsIndicators:false){HStack(spacing:8){ForEach(person.interests,id:\.self){x in Text(x).font(.caption.weight(.semibold)).padding(.horizontal,12).frame(height:32).background(Theme.panel).clipShape(Capsule())}}}
                    HStack(spacing:10){Button{store.toggle(person)}label:{Image(systemName:store.favorites.contains(person.id) ? "heart.fill":"heart").font(.title3.bold()).frame(width:56,height:56).background(Theme.panel).clipShape(Circle())};Button{}label:{Label("Invia messaggio",systemImage:"paperplane.fill").font(.headline.bold()).frame(maxWidth:.infinity).frame(height:56).background(Theme.gradient).clipShape(RoundedRectangle(cornerRadius:16))}}
                }.padding(.horizontal,18).padding(.bottom,28)
            }
        }.background(Theme.bg).ignoresSafeArea(edges:.top).toolbar(.hidden,for:.navigationBar)
    }
}
