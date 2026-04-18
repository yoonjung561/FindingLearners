//
//  TopicButton.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/27/26.
//

import SwiftUI

struct TopicButton: View {
    @Binding var selectedTopics: [String]
    @State var isSelected: Bool
    let topic: String
    
    var body: some View {
        Button(
            action: {
                isSelected = !isSelected
                if isSelected {
                    selectedTopics.append(topic)
                }
                else {
                    selectedTopics.removeAll(where: { $0 == topic })
                }
            }) {
                Text(topic)
            }.buttonStyle(.glassProminent)
            .tint(isSelected ? .accentLight : .white)
            .foregroundStyle(isSelected ? .white : .black)
    }
}
