//
//  PostDetailView.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import SwiftUI

struct PostDetailView: View {
    @Bindable var viewModel: PostViewModel
    
    var body: some View {
        GradientBackgroundView {
            
        }
        .modifier(BackButtonModifier())
    }
}

#Preview {
    PostDetailView(viewModel: PostViewModel(post: Post.DUMMY_POST))
}
