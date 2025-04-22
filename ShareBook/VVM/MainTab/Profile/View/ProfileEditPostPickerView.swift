//
//  ProfileEditPostPickerView.swift
//  ShareBook
//
//  Created by 권형일 on 8/31/24.
//

import SwiftUI

struct ProfileEditPostPickerView: View {
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    @Bindable var viewModel: ProfileViewModel
    
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
                                    viewModel.titlePost = post
                                    navRouter.back()
                                }
                        }
                    }
                }
            }
            .modifier(BackTitleModifier(navigationTitle: "글 선택"))
        }
    }
}

#Preview {
    ProfileEditPostPickerView(viewModel: ProfileViewModel(userId: "DUMMY"))
        .environment(NavigationRouter())
}
