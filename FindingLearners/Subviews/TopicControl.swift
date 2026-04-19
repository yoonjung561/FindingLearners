//
//  TopicControl.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/27/26.
//

import SwiftUI
import SwiftData

struct TopicControl: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    @Environment(\.modelContext) var context
    
    var myTopics: [String] {
        currentLearners.first?.favTopics ?? []
    }
    
    @Binding var currentTopic: String
    
    var body: some View {
        TabView(selection: $currentTopic) {
            ForEach(myTopics, id: \.self) { topic in
                Text(topic)
                    .font(Font.largeTitle.bold())
                    .foregroundStyle(.white)
                    .tag(topic)
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
    TopicControl(currentTopic: .constant("1"))
}
