//
//  PostView.swift
//  ShareBook
//
//  Created by 권형일 on 8/24/24.
//

import SwiftUI
import Kingfisher

struct PostCoverView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @State private var viewModel: PostViewModel
    
    @State private var commentSheetCapsule = CommentSheetCapsule()
    
    var isHotPost: Bool
    
    init(post: Post, isHotPost: Bool = false) {
        self.viewModel = PostViewModel(post: post)
        self.isHotPost = isHotPost
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                navRouter.move(.PostDetailView(viewModel, commentSheetCapsule))
            } label: {
                ZStack {
                    KFImage(URL(string: viewModel.post.book.image))
                        .resizable()
                        .frame(width: isHotPost ? 210 : 150, height: isHotPost ? 270 : 200)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(.black)
                                .opacity(0.15)
                        }
                        .blur(radius: 3.0)
                    
                    VStack(spacing: 13) {
                        Image(systemName: "quote.opening")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: isHotPost ? 15 : 13)
                        
                        Text("\(viewModel.post.impressivePhrase)")
                            .fontWeight(.semibold)
                            .font(.system(size: isHotPost ? 16 : 14))
                            .foregroundStyle(.white)
                            .lineLimit(7)
                            .truncationMode(.tail)
                            .padding(.horizontal)
                        
                        Image(systemName: "quote.closing")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: isHotPost ? 15 : 13)
                    }
                }
                .padding(.top, 23)
                .padding(.bottom, 7)
            }
            
            HStack(spacing: 0) {
                Button {
                    navRouter.move(.ProfileView(viewModel.post.user, nil))
                } label: {
                    HStack(spacing: 0) {
                        if let profileImageUrl = viewModel.post.user.profileImageUrl {
                            KFImage(URL(string: profileImageUrl))
                                .resizable()
                                .frame(width: isHotPost ? 19 : 15, height: isHotPost ? 19 : 15)
                                .clipShape(Circle())
                                .padding(.leading, 13)
                            
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: isHotPost ? 19 : 15, height: isHotPost ? 19 : 15)
                                .clipShape(Circle())
                                .padding(.leading, 13)
                        }
                        
                        Text("\(viewModel.post.user.username)")
                            .font(.system(size: isHotPost ? 14 :  11))
                            .frame(width: 30, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .opacity(0.8)
                            .padding(.leading, 5)
                    }
                }
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.isLike ? viewModel.unLike() : viewModel.like()
                    }
                } label: {
                    Image(systemName: viewModel.isLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: isHotPost ? 15 : 12)
                        .foregroundStyle(Color.sBColor)
                    
                }
                .padding(.trailing, 3)
                
                Text("\(viewModel.post.likeCount)")
                    .font(.system(size: isHotPost ? 13: 10))
                    .foregroundStyle(Color.sBColor)
                    .padding(.trailing, 7)
                
                Button {
                    navRouter.move(.PostDetailView(viewModel, commentSheetCapsule))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        commentSheetCapsule.isCommentSheetShowing = true
                    }
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: isHotPost ? 15 : 12)
                        .foregroundStyle(Color.sBColor)
                }
                .padding(.trailing, 3)
                
                Text("\(viewModel.commentCount)")
                    .font(.system(size: isHotPost ? 13 : 10))
                    .foregroundStyle(Color.sBColor)
                    .padding(.trailing, 15)
            }
            .padding(.bottom, 20)
        }
        .frame(width: isHotPost ? 230 : 170, height: isHotPost ? 315 : 237)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
    }
}

#Preview {
    PostCoverView(post: Post.DUMMY_POST)
        .environment(NavRouter())
}

