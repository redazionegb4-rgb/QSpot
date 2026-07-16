import SwiftUI

struct ProfileView: View {
    @State private var online=true
    @State private var hideDistance=false
    var body: some View {
        ScrollView {
            VStack(spacing:18) {
                HStack{Text("Profilo").font(.system(size:29,weight:.bold));Spacer();Image(systemName:"gearshape.fill").foregroundStyle(Theme.lilac)}
                VStack(spacing:12){Image("p1").resizable().scaledToFill().frame(width:102,height:102).clipShape(Circle()).overlay(Circle().stroke(Theme.lilac,lineWidth:3));Text("Alessandro").font(.title2.bold());Text("@alessandro_97").foregroundStyle(Theme.secondary);VStack(alignment:.leading,spacing:7){HStack{Text("Profilo completato");Spacer();Text("68%")}.font(.caption);ProgressView(value:0.68).tint(Theme.lilac)}}.padding(18).background(Theme.panel).clipShape(RoundedRectangle(cornerRadius:22))
                VStack(spacing:0){row("person.crop.circle","Modifica profilo");row("slider.horizontal.3","Preferenze");row("shield.fill","Privacy e sicurezza");row("checkmark.seal.fill","Verifica profilo");row("bell.fill","Notifiche");row("person.2.slash.fill","Utenti bloccati")}.padding(.horizontal,14).background(Theme.panel).clipShape(RoundedRectangle(cornerRadius:22))
                VStack(alignment:.leading,spacing:14){Toggle("Mostra stato online",isOn:$online);Toggle("Nascondi distanza",isOn:$hideDistance)}.padding(16).background(Theme.panel).clipShape(RoundedRectangle(cornerRadius:22))
            }.padding(.horizontal,14).padding(.top,10).padding(.bottom,18)
        }.background(Theme.bg)
    }
    private func row(_ icon:String,_ title:String)->some View{HStack(spacing:12){Image(systemName:icon).foregroundStyle(Theme.lilac).frame(width:25);Text(title);Spacer();Image(systemName:"chevron.right").foregroundStyle(Theme.secondary)}.padding(.vertical,15).overlay(alignment:.bottom){Rectangle().fill(Theme.line).frame(height:1)}}
}
