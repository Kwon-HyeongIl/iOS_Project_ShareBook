//
//  PostProfileCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 8/27/24.
//

import SwiftUI
import Kingfisher

struct PostProfileCoverView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @State private var viewModel: PostViewModel
    
    @State private var commentSheetCapsule = CommentSheetCapsule()
    
    init(post: Post) {
        self.viewModel = PostViewModel(post: post)
    }
    
    var body: some View {
        Button {
            navStackControlTower.push(.PostDetailView(viewModel, commentSheetCapsule))
        } label: {
            PostProfileCoverContentView(post: viewModel.post)
        }
    }
}

#Preview {
    PostProfileCoverView(post: Post.DUMMY_POST)
        .environment(NavStackControlTower())
}
