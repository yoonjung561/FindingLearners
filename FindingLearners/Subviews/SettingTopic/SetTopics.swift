//
//  SetTopics.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/29/26.
//

import SwiftUI
import SwiftData

struct SetTopics: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    var myTopics: [String] {
        currentLearners.first?.favTopics ?? []
    }
    
    let category: String
    let options: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(category)
                .bold()
            FlowLayout {
                ForEach(options, id: \.self) { option in
                    TopicButton(isSelected: (!currentLearners.isEmpty && myTopics.contains(option)), topic: option)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SetTopics(category: "category1", options: ["option1", "option2", "option3", "option4", "option5", "option6", "option7", "option8", "option9", "option10"])
        .modelContainer(for: Learner.self, inMemory: true)
}
