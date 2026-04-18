//
//  ContentView.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 3/25/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var showTopicSetter: Bool = false
    @State var showTopicPicker: Bool = false
    @State var showProfile: Bool = false
    @State var selectedTopics: [String] = []
    @State var currentTopic: String = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                ShowLearners(selectedTopics: $selectedTopics, currentTopic: $currentTopic)
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
                    
                    if !selectedTopics.isEmpty {
                        TopicControl(selectedTopics: $selectedTopics, currentTopic: $currentTopic)
                            .padding(.bottom, 64)
                    }
                    
                    Spacer()
                        
                    HStack {
                        SetTopicButton(showModal: $showTopicSetter, selectedTopics: $selectedTopics, currentTopic: $currentTopic)
                        
                        if !selectedTopics.isEmpty {
                            PickTopicButton(showTopicPicker: $showTopicPicker, selectedTopics: $selectedTopics, currentTopic: $currentTopic)
                        }
                    }
                }
                
                if selectedTopics.isEmpty {
                    TopicEmptyMessage()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
