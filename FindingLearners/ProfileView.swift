//
//  ProfileView.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/15/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
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
                //save data
                
                self.showProfile = false
            }
            .font(.title3)
            .buttonStyle(.glassProminent)
            .tint(.accent)
        }
        .padding(.horizontal, 30)
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
