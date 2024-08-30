//
//  ProfileEditView.swift
//  ShareBook
//
//  Created by 권형일 on 8/29/24.
//

import SwiftUI

struct ProfileEditView: View {
    @State private var viewModel: ProfileEditViewModel
    
    init(user: User?) {
        self.viewModel = ProfileEditViewModel(user: user)
    }
    
    var body: some View {
        GradientBackgroundView {
            VStack {
            }
        }
        .navigationTitle("프로필 편집")
        .modifier(BackButtonModifier())
    }
}

#Preview {
    ProfileEditView(user: User.DUMMY_USER)
}
