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
    
    let imageName: String
    @Binding var learnersInfo: [String: [String]]
    @State var isShowingInfo: Bool = false
    var learnerTopic: [String] {
            learnersInfo[imageName] ?? []
    }
    
    var body: some View {
        
        Button {
            isShowingInfo.toggle()
        }
        label: {
            Image(imageName)
                .resizable()
                .clipShape(Circle())
        }
        .buttonStyle(.glass)
        .frame(width: 110, height: 110)
        .sheet(isPresented: $isShowingInfo) {
            LearnerInfo(imageName: imageName, learnerTopic: learnersInfo[imageName]!, isShowingInfo: $isShowingInfo)
                .presentationDetents([.fraction(0.7), .large])
        }
    }
}

#Preview {
    LearnerButton(imageName: "test", learnersInfo: .constant([:]))
}
