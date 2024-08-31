//
//  ProfileEditPostPickerView.swift
//  ShareBook
//
//  Created by 권형일 on 8/31/24.
//

import SwiftUI

struct ProfileEditPostPickerView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @Bindable var viewModel: ProfileEditViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: viewModel.calSizeBase4And393(proxyWidth: proxy.size.width)) {
                        ForEach(viewModel.posts) { post in
                            PostProfileCoverContentView(post: post)
                                .scaleEffect(viewModel.calSizemBase1And393(proxyWidth: proxy.size.width))
                                .onTapGesture {
                                    viewModel.titleBookImageUrl = post.book.image
                                    viewModel.titleBookImpressivePhrase = post.impressivePhrase
                                    viewModel.titlePostId = post.id
                                    
                                    navStackControlTower.pop()
                                }
                        }
                    }
                }
            }
            .navigationTitle("나의 인생 책 구절 선택")
        .modifier(BackButtonModifier())
        }
    }
}

#Preview {
    ProfileEditPostPickerView(viewModel: ProfileEditViewModel())
        .environment(NavStackControlTower())
        .environment(ProfileViewModel(user: User.DUMMY_USER))
}
