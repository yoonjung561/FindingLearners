//
//  ContentView.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/25/26.
//

import SwiftUI
import SwiftData

struct SuperContentView: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    @Environment(\.modelContext) var context
    var myTopics: [String] {
        currentLearners.first?.favTopics ?? []
    }
    let apiClient = APIClient()
    
    var body: some View {
        ContentView(myTopics: myTopics, currentTopic: myTopics.first ?? "")
            .task {
                guard currentLearners.isEmpty else { return }
                
                let learnerDatas = try? await apiClient.request(urlString: "https://raw.githubusercontent.com/yoonjung561/FindingLearners/refs/heads/main/MockData/learnerData.json", type: [LearnerData].self)
                let messageDatas = try? await apiClient.request(urlString: "https://raw.githubusercontent.com/yoonjung561/FindingLearners/refs/heads/main/MockData/messageData.json", type: [MessageData].self)
                
                if let checkedLearnerDatas = learnerDatas {
                    for learnerData in checkedLearnerDatas {
                        let newLearnerData = Learner(fromStruct: learnerData)
                        context.insert(newLearnerData)
                    }
                    
                }
                
                if let checkedMessageDatas = messageDatas {
                    for messageData in checkedMessageDatas {
                        let newMessageData = Message(fromStruct: messageData)
                        context.insert(newMessageData)
                    }
                    
                }
            }
    }
}

struct ContentView: View {
    @State var showTopicSetter: Bool = false
    @State var showTopicPicker: Bool = false
    @State var showProfile: Bool = false
    @State var currentTopic: String
    var myTopics: [String]
    
    init(myTopics: [String], currentTopic: String) {
        self.myTopics = myTopics
        self.currentTopic = currentTopic
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                ShowLearners(currentTopic: $currentTopic)
                    .padding(.bottom, 25)
                
                VStack {
                    HStack {
                        Button("MyProfile", systemImage: "person.crop.circle") {
                            self.showProfile = true
                        }
                        .sheet(isPresented: self.$showProfile) {
                            ProfileView(showProfile: $showProfile)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: MessageView()) {
                           Image(systemName: "envelope")
                        }
                    }
                    .padding(20)
                    .font(.title)
                    .tint(.accentLight)
                    .labelStyle(.iconOnly)
                    
                    Spacer()
                    
                    if !myTopics.isEmpty {
                        TopicControl(currentTopic: $currentTopic)
                            .padding(.bottom, 64)
                    }
                    
                    Spacer()
                        
                    HStack {
                        SetTopicButton(showModal: $showTopicSetter, currentTopic: $currentTopic)
                        
                        if !myTopics.isEmpty {
                            PickTopicButton(showTopicPicker: $showTopicPicker, currentTopic: $currentTopic)
                        }
                    }
                }
                
                if myTopics.isEmpty {
                    TopicEmptyMessage()
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(SampleData.container)
//}

#Preview {
    SuperContentView()
        .modelContainer(SampleData.container)
}
