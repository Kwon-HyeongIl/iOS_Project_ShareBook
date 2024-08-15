//
//  CommentView.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import SwiftUI

struct CommentView: View {
    @State var viewModel: CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CommentView(post: Post.DUMMY_POST)
}
