//
//  TopicControl.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/27/26.
//

import SwiftUI

struct TopicControl: View {
    @Binding var selectedTopics: [String]
    @Binding var currentTopic: String
    
    var body: some View {
        TabView(selection: $currentTopic) {
            ForEach(selectedTopics, id: \.self) { topic in
                Text(topic)
                    .font(Font.largeTitle.bold())
                    .foregroundStyle(.white)
            }
        }
        .frame(width: 120, height: 160)
        .padding(.horizontal, 20)
        .background(RoundedRectangle(cornerRadius: 30)
            .foregroundStyle(Gradient(colors: [.accent, .accentDark])))
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .shadow(radius: 15)
    }
}

#Preview {
    TopicControl(selectedTopics: .constant(["1", "2", "3", "4", "5"]), currentTopic: .constant("1"))
}
