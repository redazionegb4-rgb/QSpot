import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing:16) {
                    header
                    filters

                    LazyVGrid(columns:[
                        GridItem(.flexible(), spacing:8),
                        GridItem(.flexible(), spacing:8)
                    ], spacing:8) {
                        ForEach(store.filtered) { person in
                            NavigationLink(value: person) {
                                PersonCard(person: person)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal,12)
                .padding(.top,8)
                .padding(.bottom,16)
            }
            .background(Theme.bg)
            .navigationDestination(for: Person.self) { PersonDetailView(person:$0) }
            .toolbar(.hidden, for:.navigationBar)
        }
    }

    private var header: some View {
        VStack(spacing:12) {
            HStack {
                HStack(spacing:9) {
                    ZStack {
                        Circle().fill(Theme.accent).frame(width:34,height:34)
                        Text("Q").font(.system(size: 17, weight: .black, design: .rounded)).foregroundStyle(.black)
                    }
                    Text("QSPOT")
                        .font(.system(size:25, weight:.black, design:.rounded))
                        .tracking(-1)
                }
                Spacer()
                Button {} label: {
                    Image(systemName:"slider.horizontal.3")
                        .foregroundStyle(.black)
                        .frame(width:38,height:38)
                        .background(Theme.accent)
                        .clipShape(Circle())
                }
            }

            HStack(spacing:10) {
                Image(systemName:"magnifyingglass").foregroundStyle(.secondary)
                TextField("Cerca", text:$store.query)
            }
            .padding(.horizontal,14)
            .frame(height:44)
            .background(Theme.card)
            .clipShape(RoundedRectangle(cornerRadius:14, style:.continuous))
        }
    }

    private var filters: some View {
        ScrollView(.horizontal, showsIndicators:false) {
            HStack(spacing:8) {
                ForEach(["Tutti","Online","Verificati","Vicini"], id:\.self) { item in
                    Button {
                        store.filter = item
                    } label: {
                        HStack(spacing:6) {
                            if item == "Online" {
                                Circle().fill(Color.green).frame(width:7,height:7)
                            }
                            Text(item)
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(store.filter == item ? .black : .white)
                        .padding(.horizontal,14)
                        .frame(height:36)
                        .background(store.filter == item ? Theme.accent : Theme.card)
                        .clipShape(Capsule())
                    }
                }
            }
        }
    }
}

struct PersonCard: View {
    @EnvironmentObject var store: AppStore
    let person: Person

    var body: some View {
        ZStack(alignment:.bottomLeading) {
            Image(person.image)
                .resizable()
                .scaledToFill()
                .frame(height:245)
                .clipped()

            LinearGradient(
                colors:[.clear,.black.opacity(0.05),.black.opacity(0.92)],
                startPoint:.top,
                endPoint:.bottom
            )

            VStack(alignment:.leading, spacing:4) {
                HStack(spacing:5) {
                    Text("\(person.name), \(person.age)")
                        .font(.headline.bold())
                    if person.verified {
                        Image(systemName:"checkmark.seal.fill")
                            .font(.caption)
                            .foregroundStyle(Theme.accent)
                    }
                }
                HStack(spacing:6) {
                    Circle().fill(person.online ? Color.green : Color.gray)
                        .frame(width:7,height:7)
                    Text(person.distance)
                        .font(.caption2)
                        .foregroundStyle(Color.white.opacity(0.75))
                }
            }
            .padding(11)

            VStack {
                HStack {
                    Spacer()
                    Button {
                        store.toggle(person)
                    } label: {
                        Image(systemName: store.favorites.contains(person.id) ? "star.fill" : "star")
                            .foregroundStyle(store.favorites.contains(person.id) ? Theme.accent : .white)
                            .frame(width:34,height:34)
                            .background(.black.opacity(0.36))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .padding(9)
        }
        .frame(height:245)
        .clipShape(RoundedRectangle(cornerRadius:16, style:.continuous))
    }
}
