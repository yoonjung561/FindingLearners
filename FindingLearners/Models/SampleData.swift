//
//  SampleData.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/19/26.
//

import Foundation
import SwiftData

// preview를 위한 SampleData

@MainActor
struct SampleData {
    static let container: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Learner.self, configurations: config)
            
            let context = container.mainContext
            
            let learnersInfo: [String: [String]] = [
                "ELLIE": ["개발", "기획", "야구", "케이팝", "인디", "영화", "드라마", "독서", "DIY 공방", "한식", "양식", "고기", "디저트", "영어", "일본어", "회화 연습", "여행", "베이킹"],
                "JAKE": ["개발", "디자인", "러닝", "팝송", "영화", "일식", "영어", "게임", "재테크"],
                "SOPHIA": ["기획", "필라테스", "러닝", "요가", "케이팝", "전시", "뮤지컬", "양식", "비건", "프랑스어", "여행", "패션", "코스메틱"],
                "RYAN": ["비지니스", "축구", "농구", "힙합", "R&B", "영화", "고기", "중식", "영어", "게임", "캠핑"],
                "LINA": ["디자인", "수영", "테니스", "인디", "발라드", "독서", "연극", "디저트", "일본어", "회화 연습", "여행", "사진"],
                "MARK": ["개발", "러닝", "배드민턴", "밴드", "페스티벌", "한식", "고기", "언어 자격증", "영어", "독일어", "재테크", "요리"],
                "CHLOE": ["기획", "비지니스", "서핑", "팝송", "클래식", "전시", "콘서트", "해산물", "이탈리아어", "디저트", "수집", "여행"],
                "NOAH": ["개발", "축구", "야구", "힙합", "영화", "분식", "고기", "영어", "게임", "캠핑"],
                "EMMA": ["개발", "디자인", "요가", "케이팝", "재즈", "뮤지컬", "드라마", "디저트", "비건", "프랑스어", "회화 연습", "패션", "베이킹"],
                "LUCAS": ["개발", "테니스", "러닝", "팝송", "영화", "일식", "해산물", "독일어", "언어 자격증", "여행", "사진"],
                "MIA": ["기획", "필라테스", "케이팝", "발라드", "독서", "DIY 공방", "한식", "분식", "중국어", "요리", "코스메틱"],
                "IAN": ["비지니스", "농구", "수영", "R&B", "밴드", "콘서트", "중식", "고기", "영어", "재테크", "수집"],
                "ZOE": ["개발", "배드민턴", "클래식", "연극", "페스티벌", "양식", "디저트", "일본어", "이탈리아어", "케이팝", "회화 연습", "패션", "여행"],
                "ALEX": ["디자인", "축구", "러닝", "인디", "영화", "전시", "고기", "분식", "영어", "게임", "캠핑"],
                "YUNA": ["기획", "서핑", "케이팝", "재즈", "드라마", "독서", "일식", "해산물", "중국어", "회화 연습", "사진", "베이킹", "러닝"]
            ]
            
            // DB 삽입
            for (name, topics) in learnersInfo {
                let isMe = (name == "ELLIE") // ELLIE만 true
                let learner = Learner(
                    isCurrentUser: isMe,
                    name: name,
                    email: "\(name.lowercased())@example.com",
                    favTopics: topics
                )
                context.insert(learner)
            }
            
            return container
        } catch {
            fatalError("Failed to create Sample ModelContainer: \(error)")
        }
    }()
}
