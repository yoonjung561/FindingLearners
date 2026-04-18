//
//  LearnerButton.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/30/26.
//

import SwiftUI

struct LearnerButton: View {
    let imageName: String
    @Binding var learnersInfo: [String: [String]]
    @State var isShowingInfo: Bool = false
    var learnerTopic: [String] {
            learnersInfo[imageName] ?? []
    }
    @Binding var selectedTopics: [String]
    
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
            LearnerInfo(imageName: imageName, learnerTopic: learnersInfo[imageName]!, isShowingInfo: $isShowingInfo, selectedTopics: $selectedTopics)
                .presentationDetents([.fraction(0.7), .large])
        }
    }
}

#Preview {
    LearnerButton(imageName: "test", learnersInfo: .constant([:]), selectedTopics: .constant([]))
}
