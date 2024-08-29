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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ProfileEditView(user: User.DUMMY_USER)
}
