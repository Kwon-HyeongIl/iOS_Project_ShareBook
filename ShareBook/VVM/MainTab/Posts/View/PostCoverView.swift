//
//  PostCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import SwiftUI
import Kingfisher

struct PostCoverView: View {
    @State private var viewModel: PostViewModel
    
    init(post: Post) {
        self.viewModel = PostViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            NavigationLink {
                PostDetailView(viewModel: viewModel)
            } label: {
                ZStack {
                    KFImage(URL(string: viewModel.post.book.image))
                        .resizable()
                        .frame(width: 180, height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .blur(radius: 3.0)
                    
                    Text("\(viewModel.post.impressivePhrase)")
                        .fontWeight(.semibold)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                }
                .padding(.top, 30)
            }
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: viewModel.isLike ? "heart.fill" : "heart")
                        .foregroundStyle(Color.sBColor)
                }
                .padding(.leading, 35)
                
                Button {
                    
                } label: {
                    Image(systemName: "bubble.right")
                        .foregroundStyle(Color.sBColor)
                }
                
                Spacer()
                
                Text("\(viewModel.post.user.username)")
                    .foregroundStyle(Color.sBColor)
                    .padding(.trailing, 35)
            }
            .padding(.top, 1)
            .padding(.bottom, 20)
        }
        .frame(width: 240, height: 300)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 5)
        .padding(.vertical, 20)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
    }
}


#Preview {
    PostCoverView(post: Post.DUMMY_POST)
}
