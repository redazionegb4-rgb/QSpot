import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack(spacing:18) {
                HStack {
                    Text("Profilo").font(.system(size:29, weight:.bold))
                    Spacer()
                    Image(systemName:"gearshape.fill").foregroundStyle(Theme.accent)
                }

                VStack(spacing:14) {
                    ZStack {
                        Circle().fill(Theme.accent).frame(width:104,height:104)
                        Image(systemName:"person.fill")
                            .font(.system(size:40))
                            .foregroundStyle(.black)
                    }

                    Text("Il tuo profilo").font(.title2.bold())
                    Text("Completa il profilo per ricevere più interazioni.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    Button {} label: {
                        Text("Modifica profilo")
                            .font(.headline.bold())
                            .foregroundStyle(.black)
                            .frame(maxWidth:.infinity)
                            .frame(height:50)
                            .background(Theme.accent)
                            .clipShape(RoundedRectangle(cornerRadius:14,style:.continuous))
                    }
                }
                .padding(20)
                .background(Theme.card)
                .clipShape(RoundedRectangle(cornerRadius:18,style:.continuous))

                VStack(spacing:0) {
                    row("slider.horizontal.3","Preferenze incontri")
                    row("location.fill","Distanza e posizione")
                    row("shield.fill","Privacy e sicurezza")
                    row("bell.fill","Notifiche")
                    row("questionmark.circle.fill","Assistenza")
                }
                .padding(.horizontal,16)
                .background(Theme.card)
                .clipShape(RoundedRectangle(cornerRadius:18,style:.continuous))
            }
            .padding(.horizontal,14)
            .padding(.top,10)
            .padding(.bottom,16)
        }
        .background(Theme.bg)
    }

    private func row(_ icon:String,_ title:String) -> some View {
        HStack(spacing:13) {
            Image(systemName:icon).foregroundStyle(Theme.accent).frame(width:25)
            Text(title)
            Spacer()
            Image(systemName:"chevron.right").foregroundStyle(.secondary)
        }
        .padding(.vertical,16)
        .overlay(alignment:.bottom) {
            Rectangle().fill(Color.white.opacity(0.05)).frame(height:1)
        }
    }
}
