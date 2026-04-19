//
//  PickTopicButton.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/18/26.
//

import SwiftUI

struct PickTopicButton: View {
    @Binding var showTopicPicker: Bool
    @Binding var currentTopic: String
    
    var body: some View {
        Button("관심사 변경",
                 systemImage: "filemenu.and.pointer.arrow",
            action: {
                self.showTopicPicker = true
            })
            .font(.title3)
            .tint(.accentLight)
            .foregroundStyle(.white)
            .sheet(isPresented: self.$showTopicPicker)
        {
            TopicPicker(currentTopic: $currentTopic)
                .presentationDetents([.fraction(0.54), .fraction(0.65)])
        }
        .buttonStyle(.glassProminent)
        .padding(.leading, 10)
    }
}

#Preview {
    PickTopicButton(showTopicPicker: .constant(true), currentTopic: .constant(""))
}
