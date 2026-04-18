//
//  ModalView.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/27/26.
//

import SwiftUI

struct TempModalView : View {
    @Binding var selectedTopics: [String]
    @Binding var currentTopic: String
    @Binding var showModal: Bool
    
    private let options1: [String] = ["개발", "디자인", "기획", "비지니스"] // 관심 분야
    private let options2: [String] = ["축구", "농구", "야구", "러닝", "배드민턴", "테니스", "수영", "서핑", "필라테스", "요가"] // 스포츠
    private let options3: [String] = ["케이팝", "팝송", "힙합", "인디", "발라드", "R&B", "밴드", "클래식", "재즈"] // 음악
    private let options4: [String] = ["영화", "드라마", "전시", "뮤지컬", "연극", "콘서트", "페스티벌", "독서", "DIY 공방"] // 문화생활
    private let options5: [String] = ["한식", "일식", "중식", "양식", "분식", "고기", "해산물", "비건", "디저트"] // 음식
    private let options6: [String] = ["영어", "일본어", "중국어", "프랑스어", "독일어", "이탈리아어", "언어 자격증", "회화 연습"] // 외국어
    private let options7: [String] = ["게임", "여행", "캠핑", "사진", "수집", "재테크", "패션", "코스메틱", "요리", "베이킹"] // 기타 취미

    
    var categoryAndOptions: [String: [String]] {
        ["Category1": options1, "Category2": options2, "Category3": options3, "Category4": options4, "Category5": options5, "Category6": options6, "Category7": options7]
    }
        
        var body: some View {
            ScrollView {
                VStack {
                    VStack {
                        Text("관심 있거나 흥미로운 주제를 모두 선택해주세요!")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .padding(.bottom, 2)
                        Text("같은 관심사를 가진 러너들을 찾아볼 수 있어요.")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .padding(.horizontal, 30)
                    .background(RoundedRectangle(cornerRadius: 30)
//                        .fill(.ultraThinMaterial))
                        .foregroundStyle(.accent))
                    .padding(.top)
                    
                    SetTopics(selectedTopics: $selectedTopics, category: "관심 분야", options: categoryAndOptions["Category1"] ?? [])
                    
                    SetTopics(selectedTopics: $selectedTopics, category: "스포츠", options: categoryAndOptions["Category2"] ?? [])
                    
                    SetTopics(selectedTopics: $selectedTopics, category: "음악", options: categoryAndOptions["Category3"] ?? [])
                    
                    SetTopics(selectedTopics: $selectedTopics, category: "문화 생활", options: categoryAndOptions["Category4"] ?? [])
                    
                    SetTopics(selectedTopics: $selectedTopics, category: "음식", options: categoryAndOptions["Category5"] ?? [])
                    
                    SetTopics(selectedTopics: $selectedTopics, category: "외국어", options: categoryAndOptions["Category6"] ?? [])
                    
                    SetTopics(selectedTopics: $selectedTopics, category: "기타 취미", options: categoryAndOptions["Category7"] ?? [])
                    
                    
                    
                    VStack(alignment: .leading, spacing: 15) {
                        if !selectedTopics.isEmpty{
                            Divider()
                                .padding(.top)
                            
                            Text("내가 선택한 관심사")
                                .bold()
                        }
                        FlowLayout {
                            ForEach(selectedTopics, id: \.self) { topic in
                                Text(topic)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.accentLight))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding()
                    
                    Button("설정 완료") {
                        self.showModal = false
                        currentTopic = selectedTopics.first ?? ""
                    }
                    .font(.title3)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
}

#Preview {
    TempModalView(selectedTopics: .constant([]), currentTopic: .constant(""), showModal: .constant(true))
}

