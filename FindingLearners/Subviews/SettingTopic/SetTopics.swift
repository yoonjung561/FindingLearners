//
//  SetTopics.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/29/26.
//

import SwiftUI

struct SetTopics: View {
    @Binding var selectedTopics: [String]
    let category: String
    let options: [String]
    let columns = [GridItem(.adaptive(minimum: 70))]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(category)
                .bold()
            FlowLayout {
                ForEach(options, id: \.self) { option in
                    TopicButton(selectedTopics: $selectedTopics, isSelected: (selectedTopics.contains(option) ? true : false), topic: option)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SetTopics(selectedTopics: .constant([]), category: "category1", options: ["option1", "option2", "option3", "option4", "option5", "option6", "option7", "option8", "option9", "option10"])
}
