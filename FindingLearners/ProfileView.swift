//
//  ProfileView.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/15/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State var selectedItems: [PhotosPickerItem] = []
    @State var nickname: String = ""
    @State var email: String = ""
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            Text("프로필 설정")
                .font(.title3)
                .padding(.bottom, 100)
                .padding(.top, 36)
            
            PhotosPicker(selection: $selectedItems,
                         maxSelectionCount: 1,
                         matching: .images) {
                Label("FrofileImage", systemImage: "photo.badge.plus")
                    .labelStyle(.iconOnly)
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                    .frame(width: 150, height: 150)
                    .background(.accentLight)
                    .clipShape(Circle())
            }
                         .padding(.bottom, 70)

            //이미지 선택 테스트용
            ForEach(selectedItems, id: \.self) { item in
                Text("선택됨: \(String(describing: item))")
                    .font(.caption)
                    .lineLimit(1)
            }
            
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
}

#Preview {
    ProfileView(showProfile: .constant(true))
}
