//
//  ProfileView.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/15/26.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ProfileView: View {
    @Query(filter: #Predicate<Learner> { $0.isCurrentUser == true }) var currentLearners: [Learner]
    @Environment(\.modelContext) var context
    
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    @State var nickname: String = ""
    @State var email: String = ""
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            Text("프로필 설정")
                .font(.title3)
                .padding(.bottom, 100)
                .padding(.top, 36)
            
            photoPicker
                .padding(.bottom, 70)
            
            VStack(alignment: .leading) {
                Text("Academy Nickname")
                    .font(.subheadline)
                TextField("ex. APPLE", text: $nickname)
                    .font(.title2)
            }
            .padding(.bottom, 30)
            
            VStack(alignment: .leading) {
                Text("Academy Email")
                    .font(.subheadline)
                TextField("ex. applekim26 @ pos.idserve.net", text: $email)
                    .font(.title2)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
            }
            
            Spacer()
            
            Button("프로필 저장") {
                if let currentLearner = currentLearners.first {
                    currentLearner.name = nickname
                    currentLearner.email = email
                    currentLearner.imageData = imageData
                } else {
                    let currentLearner = Learner(isCurrentUser: true, name: nickname, email: email, favTopics: [], imageData: imageData)
                    context.insert(currentLearner)
                }
                
                self.showProfile = false
            }
            .font(.title3)
            .buttonStyle(.glassProminent)
            .tint(.accent)
        }
        .padding(.horizontal, 30)
        .onAppear {
            if let currentLearner = currentLearners.first {
                self.nickname = currentLearner.name
                self.email = currentLearner.email
                self.imageData = currentLearner.imageData
            }
        }
    }
    
    private var photoPicker: some View {
        PhotosPicker(selection: $newImage) {
            Group {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                } else {
                    Image(systemName: "photo.badge.plus")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .frame(maxWidth: 150, maxHeight: 150)
                        .background(.secondary)
                }
            }
            .frame(width: 150, height: 150)
            .clipShape(Circle())
        }
        .onChange(of: newImage) {
            guard let newImage else { return }
            Task {
                imageData = try await newImage.loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    ProfileView(showProfile: .constant(true))
}
