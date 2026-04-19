//
//  LearnerButton.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/30/26.
//

import SwiftUI
import SwiftData

struct LearnerButton: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    var myTopics: [String] {
        currentLearners.first?.favTopics ?? []
    }
    
    let learner: Learner
    @State var isShowingInfo: Bool = false
    
    var body: some View {
        
        Button {
            isShowingInfo.toggle()
        }
        label: {
            Image(learner.name)
                .resizable()
                .clipShape(Circle())
        }
        .buttonStyle(.glass)
        .frame(width: 110, height: 110)
        .sheet(isPresented: $isShowingInfo) {
            LearnerInfo(learner: learner, isShowingInfo: $isShowingInfo)
                .presentationDetents([.fraction(0.7), .large])
        }
    }
}

#Preview {
    LearnerButton(learner: Learner(isCurrentUser: false, name: "TEST", email: "test@pos.idserve.net", favTopics: []))
}
