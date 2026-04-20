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
    @Query var allMessages: [Message]
    
    var filteredMessages: [Message] {
        guard let myEmail = currentLearners.first?.email else { return [] }
        
        if messageCategory == .incoming {
            return allMessages.filter { $0.recipient.email == myEmail }
        } else {
            return allMessages.filter { $0.sender.email == myEmail }
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
            
            List {
                ForEach(filteredMessages) { message in
                    MessageListItem(message: message, messageCategory: $messageCategory)
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MessageView()
}
