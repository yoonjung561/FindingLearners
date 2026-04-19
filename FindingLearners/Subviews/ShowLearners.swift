//
//  ShowLearners.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/30/26.
//

import SwiftUI
import SwiftData

struct ShowLearners: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    var myTopics: [String] {
        currentLearners.first?.favTopics ?? []
    }
    
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == false }) var otherLearners: [Learner]
    
    @Binding var currentTopic: String
    
    var body: some View {
        RadialLayout {
            ForEach(otherLearners, id: \.self) { learner in
                if learner.favTopics.contains(currentTopic) {
                    LearnerButton(learner: learner)
                }
            }
        }
        .animation(.default, value: currentTopic)
    }
}

#Preview {
    ShowLearners(currentTopic: .constant("option1"))
}
