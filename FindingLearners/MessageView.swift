//
//  RecordsView.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/15/26.
//

import SwiftUI

struct MessageView: View {
    enum MessageCategory: String, CaseIterable, Identifiable {
        case incoming, outgoing
        var id: Self { self }
    }
    
    @State private var messageCategory: MessageCategory = .incoming
    
    var body: some View {
        VStack {
            Picker("messageCategory", selection: $messageCategory) {
                Text("받은 메시지").tag(MessageCategory.incoming)
                Text("보낸 메시지").tag(MessageCategory.outgoing)
            }
            .pickerStyle(.segmented)
            
            List {
                
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MessageView()
}
