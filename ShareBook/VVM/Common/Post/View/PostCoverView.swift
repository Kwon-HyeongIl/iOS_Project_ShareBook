//
//  PostView.swift
//  ShareBook
//
//  Created by 권형일 on 8/24/24.
//

import SwiftUI
import Kingfisher

struct PostCoverView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @State private var viewModel: PostViewModel
    
    @State private var isCommentSheetShowing = false
    
    init(post: Post) {
        self.viewModel = PostViewModel(post: post)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                navStackControlTower.push(.PostDetailView(viewModel))
            } label: {
                ZStack {
                    KFImage(URL(string: viewModel.post.book.image))
                        .resizable()
                        .frame(width: 145, height: 195)
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
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                            .lineLimit(7)
                            .truncationMode(.tail)
                            .padding(.horizontal)
                        
                        Image(systemName: "quote.closing")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 13)
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, 8)
            }
            
            HStack(spacing: 0) {
                Button {
                    navStackControlTower.push(.ProfileView(viewModel.post.user))
                } label: {
                    HStack(spacing: 0) {
                        if let profileImageUrl = viewModel.post.user.profileImageUrl {
                            KFImage(URL(string: profileImageUrl))
                                .resizable()
                                .frame(width: 15, height: 15)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Color.sBColor, lineWidth: 2)
                                }
                                .padding(.leading, 13)
                            
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .clipShape(Circle())
                                .padding(.leading, 13)
                        }
                        
                        Text("\(viewModel.post.user.username)")
                            .font(.system(size: 11))
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
                        await viewModel.isLike ? viewModel.unlike() : viewModel.like()
                    }
                } label: {
                    Image(systemName: viewModel.isLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12)
                        .foregroundStyle(Color.sBColor)
                    
                }
                .padding(.trailing, 3)
                
                Text("\(viewModel.post.likeCount)")
                    .font(.system(size: 10))
                    .foregroundStyle(Color.sBColor)
                    .padding(.trailing, 7)
                
                Button {
                    isCommentSheetShowing = true
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12)
                        .foregroundStyle(Color.sBColor)
                }
                .padding(.trailing, 3)
                
                Text("\(viewModel.commentCount)")
                    .font(.system(size: 10))
                    .foregroundStyle(Color.sBColor)
                    .padding(.trailing, 15)
            }
            .padding(.bottom, 20)
        }
        .frame(width: 165, height: 235)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
        .sheet(isPresented: $isCommentSheetShowing, onDismiss: {
            Task {
                await viewModel.loadAllPostCommentAndCommentReplyCount()
            }
        }, content: {
            CommentListView(post: viewModel.post, isCommentSheetShowing: $isCommentSheetShowing)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.7), .large])
        })
    }
}

#Preview {
    PostCoverView(post: Post.DUMMY_POST)
        .environment(NavStackControlTower())
}

