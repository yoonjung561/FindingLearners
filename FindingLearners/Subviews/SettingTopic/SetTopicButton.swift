//
//  SettingTopicButton.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/15/26.
//

import SwiftUI

struct SetTopicButton: View {
    @Binding var showModal: Bool
    @Binding var selectedTopics: [String]
    @Binding var currentTopic: String
    
    var body: some View {
        Button(selectedTopics.isEmpty ? "내 관심사 설정하기" : "관심사 설정",
               systemImage: selectedTopics.isEmpty ? "person.2.badge.gearshape.fill" : "gearshape.fill",
            action: {
                self.showModal = true
            })
            .font(.title3)
            .tint(selectedTopics.isEmpty ? .accent : .accentLight)
            .foregroundStyle(.white)
            .sheet(isPresented: self.$showModal)
        {
            SetTopicView(selectedTopics: $selectedTopics, currentTopic: $currentTopic, showModal: $showModal)
                .presentationDetents([.fraction(0.54)])
        }
        .buttonStyle(.glassProminent)
        .labelStyle(.titleAndIcon)
        .padding(.leading, selectedTopics.isEmpty ? 0 : 10)
    }
}

#Preview {
    SetTopicButton(showModal: .constant(false), selectedTopics: .constant([]), currentTopic: .constant(""))
}
