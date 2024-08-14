//
//  MyPostsPostCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import SwiftUI
import Kingfisher

struct MyPostsPostCoverView: View {
    @State private var viewModel: MyPostsPostViewModel
    
    init(post: Post) {
        self.viewModel = MyPostsPostViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            NavigationLink {
//                HomePostDetailView(viewModel: viewModel)
            } label: {
                ZStack {
                    KFImage(URL(string: viewModel.post.book.image))
                        .resizable()
                        .frame(width: 130, height: 190)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .blur(radius: 3.0)
                    
                    Text("\(viewModel.post.impressivePhrase)")
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .lineLimit(7)
                        .truncationMode(.tail)
                        .padding(.horizontal)
                }
                .padding(.top, 30)
            }
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: viewModel.isLike ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 13, height: 13)
                        .foregroundStyle(Color.sBColor)
                }
                .padding(.leading, 35)
                
                Button {
                    
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .frame(width: 13, height: 13)
                        .foregroundStyle(Color.sBColor)
                }
                
                Spacer()
                
                Text("\(viewModel.post.user.username)")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.sBColor)
                    .frame(width: 70, alignment: .trailing)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.trailing, 35)
                    
            }
            .padding(.top, 1)
            .padding(.bottom, 20)
        }
        .frame(width: 160, height: 240)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(15)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
    }
}

#Preview {
    MyPostsPostCoverView(post: Post.DUMMY_POST)
}
