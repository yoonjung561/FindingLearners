//
//  LearnerInfo.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/31/26.
//

import SwiftUI
import SwiftData

struct LearnerInfo: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    @Environment(\.modelContext) var context
    var myTopics: [String] {
        currentLearners.first?.favTopics ?? []
    }
    
    var learner: Learner
    @State var message: String = ""
    @Binding var isShowingInfo: Bool
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(learner.name)
                    .resizable()
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                
                Text(learner.name)
                    .font(.largeTitle)
                    .padding(.bottom, 5)
                    .padding(.trailing, 10)
                    .frame(maxWidth: .infinity)
                    .bold()
            }
            .padding(.bottom, 30)
            .padding(.top, 20)
            
            FlowLayout {
                ForEach(learner.favTopics, id: \.self) { topic in
                    if myTopics.contains(topic) {
                        Text(topic)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.accentLight)
                            )
                            .foregroundStyle(.white)
                    }
                    else {
                        Text(topic)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.regularMaterial)
                            )
                    }
                }
            }
            .padding(.bottom, 20)
            
            TextField("러너에게 한 줄 메시지를 보내보세요!", text: $message, axis: .vertical)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.white))
                .padding(.bottom, 15)
            
            Button("전송") {
                if message != "" {
                    let newMessage = Message(sender: currentLearners.first!, recipient: learner, message: message)
                    context.insert(newMessage)
                    
                    alertMessage = "메시지 전송이 완료되었어요!"
                    message = ""
                }
                else {
                    alertMessage = "메시지가 입력되지 않았어요."
                }
                showAlert = true
            }
            .tint(.blue)
            .buttonStyle(.glassProminent)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage))
            }
            
            
            Spacer()
        }
        .padding(30)
    }
}

#Preview {
    LearnerInfo(learner: Learner(isCurrentUser: false, name: "TEST", email: "test@pos.idserve.net", favTopics: []), isShowingInfo: .constant(true))
}
