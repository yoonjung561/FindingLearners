//
//  SettingTopicButton.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/15/26.
//

import SwiftUI
import SwiftData

struct SetTopicButton: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    var myTopics: [String] {
        currentLearners.first?.favTopics ?? []
    }
    
    @Binding var showModal: Bool
    @Binding var currentTopic: String
    
    var body: some View {
        Button(myTopics.isEmpty ? "내 관심사 설정하기" : "관심사 설정",
               systemImage: myTopics.isEmpty ? "person.2.badge.gearshape.fill" : "gearshape.fill",
            action: {
                self.showModal = true
            })
            .font(.title3)
            .tint(myTopics.isEmpty ? .accent : .accentLight)
            .foregroundStyle(.white)
            .sheet(isPresented: self.$showModal)
        {
            SetTopicView(currentTopic: $currentTopic, showModal: $showModal)
                .presentationDetents([.fraction(0.54)])
        }
        .buttonStyle(.glassProminent)
        .labelStyle(.titleAndIcon)
        .padding(.leading, myTopics.isEmpty ? 0 : 10)
    }
}

#Preview {
    SetTopicButton(showModal: .constant(false), currentTopic: .constant(""))
}
