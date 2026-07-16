import SwiftUI

struct PersonDetailView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.dismiss) var dismiss
    let person: Person

    var body: some View {
        ScrollView {
            VStack(spacing:0) {
                ZStack(alignment:.bottomLeading) {
                    Image(person.hero)
                        .resizable()
                        .scaledToFill()
                        .frame(height:500)
                        .clipped()

                    LinearGradient(colors:[.black.opacity(0.15),.clear,Theme.bg], startPoint:.top, endPoint:.bottom)

                    VStack(alignment:.leading, spacing:7) {
                        HStack(spacing:6) {
                            Text("\(person.name), \(person.age)")
                                .font(.system(size:31, weight:.black))
                            if person.verified {
                                Image(systemName:"checkmark.seal.fill").foregroundStyle(Theme.accent)
                            }
                        }
                        HStack(spacing:7) {
                            Circle().fill(person.online ? Color.green : Color.gray).frame(width:8,height:8)
                            Text(person.distance).foregroundStyle(Theme.text2)
                        }
                    }
                    .padding(.horizontal,18)
                    .padding(.bottom,24)

                    VStack {
                        HStack {
                            Button { dismiss() } label: {
                                Image(systemName:"chevron.left")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    .frame(width:42,height:42)
                                    .background(.black.opacity(0.45))
                                    .clipShape(Circle())
                            }
                            Spacer()
                            Button {} label: {
                                Image(systemName:"ellipsis")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    .frame(width:42,height:42)
                                    .background(.black.opacity(0.45))
                                    .clipShape(Circle())
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal,14)
                    .padding(.top,52)
                }

                VStack(alignment:.leading, spacing:18) {
                    Text(person.bio)
                        .font(.body)
                        .lineSpacing(4)

                    ScrollView(.horizontal, showsIndicators:false) {
                        HStack(spacing:8) {
                            ForEach(person.interests,id:\.self) { interest in
                                Text(interest)
                                    .font(.caption.weight(.semibold))
                                    .padding(.horizontal,12)
                                    .frame(height:32)
                                    .background(Theme.card)
                                    .clipShape(Capsule())
                            }
                        }
                    }

                    HStack(spacing:12) {
                        Button {
                            store.toggle(person)
                        } label: {
                            Image(systemName: store.favorites.contains(person.id) ? "star.fill" : "star")
                                .font(.title3.bold())
                                .foregroundStyle(.black)
                                .frame(width:58,height:58)
                                .background(Theme.accent)
                                .clipShape(Circle())
                        }

                        Button {} label: {
                            Label("Scrivi", systemImage:"paperplane.fill")
                                .font(.headline.bold())
                                .foregroundStyle(.black)
                                .frame(maxWidth:.infinity)
                                .frame(height:58)
                                .background(Theme.accent)
                                .clipShape(RoundedRectangle(cornerRadius:16, style:.continuous))
                        }
                    }

                    HStack {
                        Text("Foto").font(.title3.bold())
                        Spacer()
                        Text("Vedi tutte")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Theme.accent)
                    }

                    HStack(spacing:8) {
                        ForEach([person.image,person.hero,"hero2"],id:\.self) { n in
                            Image(n)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth:.infinity)
                                .frame(height:120)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius:12, style:.continuous))
                        }
                    }
                }
                .padding(.horizontal,18)
                .padding(.bottom,28)
            }
        }
        .background(Theme.bg)
        .ignoresSafeArea(edges:.top)
        .toolbar(.hidden, for:.navigationBar)
    }
}
