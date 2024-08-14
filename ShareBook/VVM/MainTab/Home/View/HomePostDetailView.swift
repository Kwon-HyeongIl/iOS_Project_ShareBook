//
//  PostDetailView.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import SwiftUI

struct HomePostDetailView: View {
    @Bindable var viewModel: HomePostViewModel
    
    var body: some View {
        GradientBackgroundView {
            
        }
        .modifier(BackButtonModifier())
    }
}

#Preview {
    HomePostDetailView(viewModel: HomePostViewModel(post: Post.DUMMY_POST))
}
