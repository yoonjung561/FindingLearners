//
//  TopicEmptyMessage.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/18/26.
//

import SwiftUI

struct MessageEmptyMessage: View {
    var body: some View {
        VStack {
            Text("아직 메시지 기록이 없어요.")
                .font(.title3)
                .bold()
                .foregroundStyle(.textgray)
                .padding(.bottom, 4)
            Text("같은 관심사를 가진 러너들과")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.textgray)
            Text("소통을 시작해보세요!")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.textgray)
        }
    }
}

#Preview {
    TopicEmptyMessage()
}
