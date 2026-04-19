//
//  TopicButton.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/27/26.
//

import SwiftUI
import SwiftData

struct TopicButton: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true })var currentLearners: [Learner]
    @Environment(\.modelContext) var context
    
    @State var isSelected: Bool
    let topic: String
    
    var body: some View {
        Button(
            action: {
                isSelected = !isSelected
                
                if isSelected {
                    if currentLearners.isEmpty {
                        let currentLearner = Learner(isCurrentUser: true, name: "", email: "", favTopics: [topic])
                        context.insert(currentLearner)
                    }
                    else {
                        currentLearners.first?.favTopics.append(topic)
                    }
                }
                else {
                    currentLearners.first?.favTopics.removeAll(where: { $0 == topic })
                }
            }) {
                Text(topic)
            }.buttonStyle(.glassProminent)
            .tint(isSelected ? .accentLight : .white)
            .foregroundStyle(isSelected ? .white : .black)
    }
}
