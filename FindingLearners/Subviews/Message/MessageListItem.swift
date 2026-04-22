//
//  MessageListItem.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/20/26.
//

import SwiftUI

struct MessageListItem: View {
    @State private var showDetail: Bool = false
    
    var message: Message
    @Binding var messageCategory: MessageCategory
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(messageCategory == .incoming ? message.sender.name : message.recipient.name)
                    .resizable()
                    .frame(maxWidth: 68, maxHeight: 68)
                    .background(.accentLight)
                    .clipShape(Circle())
                    .padding(.trailing, 12)
                
                VStack(alignment: .leading) {
                    Text(messageCategory == .incoming ? message.sender.name : message.recipient.name)
                        .font(.body)
                        .foregroundStyle(.textgray)
                    Text(message.message)
                        .font(.subheadline)
                        .foregroundStyle(.textgray)
                    Text(message.timestamp, format: .dateTime.month().day().hour().minute())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Button("showDetail", systemImage: showDetail ? "chevron.up" : "chevron.down") {
                    showDetail.toggle()
                }
                .labelStyle(.iconOnly)
                .animation(.default, value: showDetail)
            }
            .padding(4)
            .padding(.bottom, 12)
            
            if showDetail {
                Text("나와의 공통 관심사")
                    .font(.subheadline)
                
                FlowLayout {
                    ForEach(message.sender.favTopics, id: \.self) { topic in
                        if message.recipient.favTopics.contains(topic) {
                            Text(topic)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.accentLight)
                                )
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.bottom, 12)
                
                Link(destination: URL(string: "https://idserve-net.zoom.us/launch/chat?src=direct_chat_link&email=\(messageCategory == .incoming ? message.sender.email : message.recipient.email)")!) {
                    Label("Zoom Chat으로 연결", systemImage: "message.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.white)
            }
        }
        .animation(.default, value: showDetail)
    }
}

#Preview {
    MessageListItem(message: Message(sender: Learner(isCurrentUser: true, name: "ELLIE", email: "yookwak26@pos.idserve.net", favTopics: ["개발", "디자인", "기획"]), recipient: Learner(isCurrentUser: false, name: "TEST", email: "test26@pos.idserve.net", favTopics: ["개발", "기획", "비지니스"]), message: "안녕하세요!"), messageCategory: .constant(.incoming))
}
