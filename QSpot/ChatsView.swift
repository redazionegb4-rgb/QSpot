import SwiftUI

struct ChatsView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        ScrollView {
            VStack(spacing:0) {
                HStack {
                    Text("Chat").font(.system(size:29, weight:.bold))
                    Spacer()
                    Image(systemName:"square.and.pencil")
                        .foregroundStyle(Theme.accent)
                        .font(.title3)
                }
                .padding(.vertical,12)

                ForEach(store.chats) { chat in
                    HStack(spacing:12) {
                        ZStack(alignment:.bottomTrailing) {
                            Image(chat.person.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width:56,height:56)
                                .clipShape(Circle())
                            if chat.person.online {
                                Circle().fill(Color.green).frame(width:13,height:13)
                                    .overlay(Circle().stroke(Theme.bg,lineWidth:2))
                            }
                        }

                        VStack(alignment:.leading, spacing:4) {
                            Text(chat.person.name).font(.headline)
                            Text(chat.preview).foregroundStyle(.secondary).lineLimit(1)
                        }

                        Spacer()

                        VStack(alignment:.trailing, spacing:7) {
                            Text(chat.time).font(.caption2).foregroundStyle(.secondary)
                            if chat.unread > 0 {
                                Text("\(chat.unread)")
                                    .font(.caption2.bold())
                                    .foregroundStyle(.black)
                                    .frame(width:21,height:21)
                                    .background(Theme.accent)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .padding(.vertical,13)

                    Divider().overlay(Color.white.opacity(0.06))
                }
            }
            .padding(.horizontal,16)
            .padding(.bottom,16)
        }
        .background(Theme.bg)
    }
}
