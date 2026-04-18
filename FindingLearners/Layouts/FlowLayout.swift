//
//  FlowLayout.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/29/26.
//

import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 10
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        // proposal : 부모뷰가 제안하는 ViewSize (여유 공간)
        // subviews : 자식뷰들의 리스트
        // cache : 복잡한 계산 결과의 임시 저장소
        // 반환값 : 모든 자식뷰의 크기 및 위치를 고려해 계산했을 때, 전체 너비와 높이
        
        var x: CGFloat = 0 // 한 줄에 존재하는 버튼의 총 너비 계산을 위한 임시 변수
        var y: CGFloat = 0 // 전체 버튼이 배치되었을 때의 총 높이 계산을 위한 임시 변수
        var maxHeight: CGFloat = 0 // 한 줄 당 최대 높이
        
        let proposalWidth = proposal.width ?? .infinity //proposal.width, proposal.height는 Optional type으로 기본값 지정 필요
        
        for view in subviews {
            let viewSize = view.sizeThatFits(.unspecified) // 제약이 존재하지 않을 때, 각 view의 size 저장
            
            if x + viewSize.width > proposalWidth {
                x = 0
                y += (maxHeight + spacing)
                maxHeight = 0
            } // 현재까지 배치된 view의 총 너비 + 추가할 view의 너비 > 부모뷰의 최대 여유 공간 조건을 충족할 때, 다음 줄로 넘어감(x 초기화, y 높이 추가)
            
            x += (viewSize.width + spacing)
            maxHeight = max(maxHeight, viewSize.height)
            // view가 들어갈 줄의 x값에 viewSize.width 추가 및 maxHeight 재계산
        }
    
        return CGSize(width: proposalWidth, height: y + maxHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // bounds : 계산 결과, 부모뷰가 허락한 실제 영역
        
        var x: CGFloat = bounds.minX // 한 줄에 존재하는 버튼의 총너비 계산을 위한 임시 변수
        var y: CGFloat = bounds.minY // 전체 버튼이 배치되었을 때의 총 높이 계산을 위한 임시 변수
        var rowHeight: CGFloat = 0 // 한 줄 당 높이(해당 줄에 포함되는 view의 최대 높이)
        
        for view in subviews {
            let viewSize = view.sizeThatFits(.unspecified) // 제약이 존재하지 않을 때, 각 view의 size 저장
            
            if x + viewSize.width > bounds.maxX {
                x = bounds.minX
                y += (rowHeight + spacing)
                rowHeight = 0
            } // 현재까지 배치된 view의 총 너비 + 추가할 view의 너비 > 사용이 허락된 영역의 크기 조건을 충족할 때, 다음 줄로 넘어감(x 초기화, y 높이 추가)
            
            view.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
            // 실제로 view를 지정 위치에 배치
            
            x += (viewSize.width + spacing)
            rowHeight = max(rowHeight, viewSize.height)
            // // view가 들어갈 줄의 x값에 viewSize.width 추가 및 maxHeight 재계산 (다음 view를 위한 위치 재정의)
        }
    }
}
