//
//  TopicEmptyMessage.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/18/26.
//

import SwiftUI

struct TopicEmptyMessage: View {
    var body: some View {
        VStack {
            Text("관심사가 설정되지 않았어요.")
                .font(.title3)
                .bold()
                .foregroundStyle(.textgray)
                .padding(.bottom, 4)
            Text("관심사를 설정하고,")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.textgray)
            Text("나와 같은 관심사를 가진 러너를 찾아보세요!")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.textgray)
        }
    }
}

#Preview {
    TopicEmptyMessage()
}
