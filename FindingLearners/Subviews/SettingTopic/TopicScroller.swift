//
//  TopicSelector.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/15/26.
//

import SwiftUI

struct TopicScroller: View {
    @Binding var selectedTopics: [String]
    @Binding var currentTopic: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(selectedTopics, id: \.self) { topic in
                    Button(topic) {
                        currentTopic = topic
                    }
                    .bold()
                    .buttonStyle(.glassProminent)
                    .tint(topic==currentTopic ? .accent : .accentLight)
                }
            }
            .padding()
            .padding(.leading, 55)
        }
    }
}

#Preview {
    TopicScroller(selectedTopics: .constant([]), currentTopic: .constant(""))
}
