import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("Chat")
                            .font(.system(size: 29, weight: .bold))
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .foregroundStyle(QTheme.blue)
                            .font(.title3)
                    }
                    .padding(.vertical, 12)

                    ForEach(store.chats) { chat in
                        HStack(spacing: 12) {
                            ZStack(alignment: .bottomTrailing) {
                                Image(chat.profile.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 54, height: 54)
                                    .clipShape(Circle())
                                if chat.profile.online {
                                    Circle()
                                        .fill(QTheme.green)
                                        .frame(width: 13, height: 13)
                                        .overlay(Circle().stroke(QTheme.background, lineWidth: 2))
                                }
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                Text(chat.profile.name)
                                    .font(.headline)
                                Text(chat.message)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 7) {
                                Text(chat.time)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                if chat.unread > 0 {
                                    Text("\(chat.unread)")
                                        .font(.caption2.bold())
                                        .frame(width: 21, height: 21)
                                        .background(QTheme.purple)
                                        .clipShape(Circle())
                                }
                            }
                        }
                        .padding(.vertical, 13)

                        Divider().overlay(Color.white.opacity(0.06))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .background(QTheme.background)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
