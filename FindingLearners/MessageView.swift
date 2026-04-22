//
//  RecordsView.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/15/26.
//

import SwiftUI
import SwiftData

struct MessageView: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == false }) var otherLearners: [Learner]
    @Query var allMessages: [Message]
    @Environment(\.modelContext) var context
    
    var filteredMessages: [Message] {
        guard let myId = currentLearners.first?.id else { return [] }
        
        if messageCategory == .incoming {
            return allMessages.filter { $0.recipient.id == myId }
        } else {
            return allMessages.filter { $0.sender.id == myId }
        }
    }
    
    @State var messageCategory: MessageCategory = .incoming
    
    var body: some View {
        VStack {
            Picker("messageCategory", selection: $messageCategory) {
                Text("받은 메시지").tag(MessageCategory.incoming)
                Text("보낸 메시지").tag(MessageCategory.outgoing)
            }
            .pickerStyle(.segmented)
            
            ZStack {
                 if filteredMessages.isEmpty {
                    VStack {
                        Text("아직 메시지 기록이 없어요.")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.textgray)
                            .padding(.bottom, 4)
                        Text("같은 관심사를 가진 러너들과")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundStyle(.textgray)
                        Text("소통을 시작해보세요!")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundStyle(.textgray)
                    }
                }
                List {
                    ForEach(filteredMessages) { message in
                        MessageListItem(message: message, messageCategory: $messageCategory)
                            .swipeActions(edge: .trailing) {
                                Button("삭제", systemImage: "trash") {
                                    context.delete(message)
                                    try? context.save()
                                }
                                .tint(.red)
                            }
                    }
                }
                .listStyle(.plain)
            }
            
            Spacer()
        }
        .padding()
        .task {
            guard (messageCategory == .incoming && filteredMessages.isEmpty) else { return }
            
            if let currentLearner = currentLearners.first {
                let newMessage1 = Message(sender: otherLearners.first(where: { $0.name == "CHLOE" })!, recipient: currentLearner, message: "다음 달에 서핑 원데이 클래스를 들어보려 하는데, 혹시 함께하실래요?")
                let newMessage2 = Message(sender: otherLearners.first(where: { $0.name == "LUCAS" })!, recipient: currentLearner, message: "주말에 러너들이랑 경주에 출사 가실래요?!")
                context.insert(newMessage1)
                context.insert(newMessage2)
            }
        }
    }
}

#Preview {
    MessageView()
}
