import SwiftUI

struct ChatsView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("Messaggi")
                            .font(.system(size: 29, weight: .bold))
                        Spacer()
                        Button {} label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title3.bold())
                                .foregroundStyle(Theme.accent)
                        }
                    }
                    .padding(.vertical, 12)

                    ForEach(store.chats) { chat in
                        Button {} label: {
                            HStack(spacing: 12) {
                                ZStack(alignment: .bottomTrailing) {
                                    Image(chat.person.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 58, height: 58)
                                        .clipShape(Circle())

                                    if chat.person.online {
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 13, height: 13)
                                            .overlay(Circle().stroke(Theme.bg, lineWidth: 2))
                                    }
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(chat.person.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(chat.preview)
                                        .font(.subheadline)
                                        .foregroundStyle(Theme.secondaryText)
                                        .lineLimit(1)
                                }

                                Spacer()

                                VStack(alignment: .trailing, spacing: 7) {
                                    Text(chat.time)
                                        .font(.caption2)
                                        .foregroundStyle(Theme.secondaryText)

                                    if chat.unread > 0 {
                                        Text("\(chat.unread)")
                                            .font(.caption2.bold())
                                            .foregroundStyle(.black)
                                            .frame(width: 22, height: 22)
                                            .background(Theme.accent)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            .padding(.vertical, 13)
                        }

                        Divider().overlay(Theme.divider)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .background(Theme.bg)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
