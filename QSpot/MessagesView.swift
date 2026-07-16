import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(store.chats) { chat in
                            HStack(spacing: 13) {
                                ZStack(alignment: .bottomTrailing) {
                                    Circle()
                                        .fill(AppTheme.gradient)
                                        .frame(width: 58, height: 58)
                                        .overlay(
                                            Image(systemName: chat.profile.symbol)
                                                .font(.title2)
                                        )

                                    if chat.profile.isOnline {
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 13, height: 13)
                                            .overlay(Circle().stroke(AppTheme.background, lineWidth: 2))
                                    }
                                }

                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text(chat.profile.name)
                                            .font(.headline)
                                        Spacer()
                                        Text(chat.time)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }

                                    HStack {
                                        Text(chat.message)
                                            .foregroundStyle(.secondary)
                                            .lineLimit(1)
                                        Spacer()
                                        if chat.unread > 0 {
                                            Text("\(chat.unread)")
                                                .font(.caption2.bold())
                                                .frame(width: 22, height: 22)
                                                .background(AppTheme.pink)
                                                .clipShape(Circle())
                                        }
                                    }
                                }
                            }
                            .padding(14)
                            .glassCard()
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Messaggi")
        }
    }
}
