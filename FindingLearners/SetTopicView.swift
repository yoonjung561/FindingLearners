//
//  SelectTopicView.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/16/26.
//

import SwiftUI
import SwiftData

struct SetTopicView: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    var myTopics: [String] {
        currentLearners.first?.favTopics ?? []
    }
    
    @Binding var currentTopic: String
    @Binding var showModal: Bool
    @State var currentTopicIndex: Int = 0
    
    private let options1: [String] = ["개발", "디자인", "기획", "비지니스"] // 관심 분야
    private let options2: [String] = ["축구", "농구", "야구", "러닝", "배드민턴", "테니스", "수영", "서핑", "필라테스", "요가"] // 스포츠
    private let options3: [String] = ["케이팝", "팝송", "힙합", "인디", "발라드", "R&B", "밴드", "클래식", "재즈"] // 음악
    private let options4: [String] = ["영화", "드라마", "전시", "뮤지컬", "연극", "콘서트", "페스티벌", "독서", "DIY 공방"] // 문화생활
    private let options5: [String] = ["한식", "일식", "중식", "양식", "분식", "고기", "해산물", "비건", "디저트"] // 음식
    private let options6: [String] = ["영어", "일본어", "중국어", "프랑스어", "독일어", "이탈리아어", "언어 자격증", "회화 연습"] // 외국어
    private let options7: [String] = ["게임", "여행", "캠핑", "사진", "수집", "재테크", "패션", "코스메틱", "요리", "베이킹"] // 기타 취미

    
    var categories: [(name: String, options: [String])] {
        [
            ("관심 분야", options1),
            ("스포츠", options2),
            ("음악", options3),
            ("문화생활", options4),
            ("음식", options5),
            ("외국어", options6),
            ("기타 취미", options7)
        ]
    }
        
    var body: some View {
        VStack {
            VStack {
                Text("관심 있거나 흥미로운 주제를 모두 선택해주세요!")
                    .font(.headline)
                    .foregroundStyle(.textgray)
                    .padding(.bottom, 4)
                Text("같은 관심사를 가진 러너들을 찾아볼 수 있어요.")
                    .font(.subheadline)
                    .foregroundStyle(.textgray)
            }
            .padding(24)
            .background(RoundedRectangle(cornerRadius: 30)
                .fill(.regularMaterial))
            .padding(.top)
            
            SetTopics(category: categories[currentTopicIndex].name, options: categories[currentTopicIndex].options)
            
            Spacer()
            
            HStack {
                if currentTopicIndex != 0 {
                    Button {
                        currentTopicIndex -= 1
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("이전")
                        }
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.accent)
                }
                
                Spacer()
                
                Button {
                    if currentTopicIndex < 6 {
                        currentTopicIndex += 1
                    }
                    else {
                        currentTopic = myTopics.first ?? ""
                        showModal = !showModal
                    }
                } label: {
                    HStack {
                        if currentTopicIndex < 6 {
                            Text("다음")
                            Image(systemName: "chevron.forward")
                        }
                        else {
                            Text("설정 완료")
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .buttonStyle(.glassProminent)
                .tint(.accent)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    SetTopicView(currentTopic: .constant(""), showModal: .constant(true))
}
