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
    
    @State var isCommentSheetShowing = false
    
    init(post: Post) {
        self.viewModel = MyPostsPostViewModel(post: post)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink {
                MyPostsPostDetailView(viewModel: viewModel)
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
                .padding(.bottom, 8)
            }
            
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
                        .padding(.leading, 18)
                        
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .clipShape(Circle())
                        .padding(.leading, 18)
                }
                
                Text("\(viewModel.post.user.username)")
                    .font(.system(size: 11))
                    .frame(width: 30, alignment: .leading)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.leading, 5)
                
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
                    .padding(.trailing, 17)
            }
            .padding(.bottom, 20)
        }
        .frame(width: 160, height: 240)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(15)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
        .sheet(isPresented: $isCommentSheetShowing, onDismiss: {
            Task {
                await viewModel.loadAllPostCommentAndCommentReplyCount()
            }
        }, content: {
            CommentListView(post: viewModel.post)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.7), .large])
        })
    }
}

#Preview {
    MyPostsPostCoverView(post: Post.DUMMY_POST)
}
