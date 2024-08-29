//
//  ProfileOptionView.swift
//  ShareBook
//
//  Created by 권형일 on 8/29/24.
//

import SwiftUI

struct ProfileOptionView: View {
    @State private var viewModel: ProfileOptionViewModel
    
    init(user: User?) {
        self.viewModel = ProfileOptionViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            Button {
                viewModel.signout()
            } label: {
                Text("로그아웃")
            }
        }
    }
}

#Preview {
    ProfileOptionView(user: User.DUMMY_USER)
}
