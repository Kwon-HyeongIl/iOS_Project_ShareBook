//
//  PostProfileCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 8/27/24.
//

import SwiftUI
import Kingfisher

struct PostProfileCoverView: View {
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    @State private var viewModel: PostViewModel
    
    @State private var commentSheetCapsule = CommentSheetCapsule()
    
    init(post: Post) {
        self.viewModel = PostViewModel(post: post)
    }
    
    var body: some View {
        Button {
            navRouter.navigate(.PostDetailView(viewModel, commentSheetCapsule))
        } label: {
            PostProfileCoverContentView(post: viewModel.post)
        }
    }
}

#Preview {
    PostProfileCoverView(post: Post.DUMMY_POST)
        .environment(NavigationRouter())
}
