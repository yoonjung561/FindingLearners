//
//  TopicPicker.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/16/26.
//

import SwiftUI

struct TopicPicker: View {
    @Binding var selectedTopics: [String]
    @Binding var currentTopic: String
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text("아래는 내가 선택한 관심사예요.")
                    .font(.headline)
                    .foregroundStyle(.textgray)
                    .padding(.bottom, 4)
                Text("관심사 중 한 가지를 선택하면")
                    .font(.subheadline)
                    .foregroundStyle(.textgray)
                Text("같은 관심사를 가진 러너들을 확인할 수 있어요!")
                    .font(.subheadline)
                    .foregroundStyle(.textgray)
            }
            .frame(maxWidth: .infinity)
            .padding(24)
            .background(RoundedRectangle(cornerRadius: 30)
                .fill(.regularMaterial))
            .padding(.vertical)
            
            ScrollView {
                FlowLayout {
                    ForEach(selectedTopics, id: \.self) { topic in
                        Button(topic) {
                            currentTopic = topic
                        }
                        .bold()
                        .buttonStyle(.glassProminent)
                        .tint(topic==currentTopic ? .accent : .accentLight)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    TopicPicker(selectedTopics: .constant(["개발", "기획", "야구",  "케이팝", "인디", "영화", "드라마", "독서", "DIY 공방", "한식", "양식", "고기", "디저트", "영어", "일본어", "회화 연습", "여행", "베이킹"]), currentTopic: .constant(""))
}
