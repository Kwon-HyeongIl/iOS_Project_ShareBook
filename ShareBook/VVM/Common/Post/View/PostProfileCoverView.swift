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
            ZStack {
                KFImage(URL(string: viewModel.post.book.image))
                    .resizable()
                    .frame(width: 125, height: 175)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .blur(radius: 3.0)
                
                VStack(spacing: 13) {
                    Image(systemName: "quote.opening")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 13)
                    
                    Text("\(viewModel.post.impressivePhrase)")
                        .fontWeight(.semibold)
                        .font(.system(size: 11))
                        .foregroundStyle(.white)
                        .lineLimit(7)
                        .truncationMode(.tail)
                        .padding(.horizontal, 5)
                    
                    Image(systemName: "quote.closing")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 13)
                }
                .frame(width: 125, height: 175)
            }
        }
    }
}

#Preview {
    PostProfileCoverView(post: Post.DUMMY_POST)
        .environment(NavStackControlTower())
}
