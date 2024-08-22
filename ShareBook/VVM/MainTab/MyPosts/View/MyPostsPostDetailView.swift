//
//  MyPostsPostDetailView.swift
//  ShareBook
//
//  Created by 권형일 on 8/20/24.
//

import SwiftUI
import Kingfisher

struct MyPostsPostDetailView: View {
    @Bindable var viewModel: MyPostsPostViewModel
    
    @State var isFeelingCaptionExpanding = false
    @State var isCommentSheetShowing = false
    
    @State var deleteAlertShowing = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GradientBackgroundView {
            ScrollView {
                VStack {
                    HStack {
                        if let profileImageUrl = viewModel.post.user.profileImageUrl {
                            KFImage(URL(string: profileImageUrl))
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                                .padding(.leading, 20)
                                
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                                .padding(.leading, 20)
                        }
                            
                        
                        Text("\(viewModel.post.user.username)")
                            .fontWeight(.semibold)
                        
                        Text("\(viewModel.post.date.relativeTimeString())")
                            .font(.system(size: 13))
                            .foregroundStyle(.gray)
                            .padding(.leading, 4)
                        
                        Spacer()
                    }
                    
                    HomeBookCoverView(book: viewModel.post.book)
                        .padding(.bottom, 10)
                        .padding(.vertical, 5)
                    
                    VStack {
                        Image(systemName: "quote.opening")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30)
                            .foregroundStyle(Color.sBColor)
                            .padding(.top, 50)
                            .padding(.bottom, 30)
                        
                        Text("\(viewModel.post.impressivePhrase)")
                            .multilineTextAlignment(.center)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "quote.closing")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30)
                            .foregroundStyle(Color.sBColor)
                            .padding(.top, 30)
                            .padding(.bottom, 50)
                        
                        Divider()
                        
                        if isFeelingCaptionExpanding {
                            Text("\(viewModel.post.feelingCaption)")
                                .font(.callout)
                                .fontWeight(.semibold)
                                .padding()
                        }
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                isFeelingCaptionExpanding.toggle()
                            }
                        } label: {
                            HStack {
                                if isFeelingCaptionExpanding {
                                    Image(systemName: "chevron.up")
                                    
                                } else {
                                    Text("느낀점")
                                        .font(.system(size: 13))
                                    
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 13)
                                }
                            }
                            .foregroundStyle(Color.sBColor)
                        }
                        .padding(.bottom, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 5) {
                        Button {
                            Task {
                                await viewModel.isLike ? viewModel.unlike() : viewModel.like()
                            }
                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: viewModel.isLike ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15)
                                    .foregroundStyle(Color.sBColor)
                                    .padding(.leading)
                                
                                Text("좋아요")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black)
                                
                                Text("\(viewModel.post.likeCount)")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.black)
                            }
                        }
                        
                        Button {
                            isCommentSheetShowing = true
                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: "bubble.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15)
                                    .foregroundStyle(Color.sBColor)
                                    .padding(.leading, 10)
                                
                                Text("댓글")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black)
                                
                                Text("\(viewModel.commentCount)")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.black)
                            }
                        }
                        
                        Spacer()
                        
                        Image(systemName: "book")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                            .foregroundStyle(Color.sBColor)

                        Text("\(viewModel.post.genre.rawValue)")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .padding(.trailing)
                        
                    }
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                    
                    
                    Button {
                        deleteAlertShowing = true
                    } label: {
                        Text("글 삭제")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                            .opacity(0.6)
                            .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                            .padding(.top)
                    }
                    .alert("삭제 하시겠습니까?", isPresented: $deleteAlertShowing) {
                        Button(role: .cancel) {
                            
                        } label: {
                            Text("취소")
                        }
                        
                        Button(role: .destructive) {
                            Task {
                                await viewModel.deletePost()
                                dismiss()
                            }
                        } label: {
                            Text("삭제")
                        }
                    } message: {
                        Text("삭제한 글은 다시 복원할 수 없습니다.")
                    }
                }
                
            }
            
        }
        .sheet(isPresented: $isCommentSheetShowing, onDismiss: {
            Task {
                await viewModel.loadAllPostCommentAndCommentReplyCount()
            }
        }, content: {
            CommentListView(post: viewModel.post)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.7), .large])
        })
        .modifier(BackButtonModifier())
    }
}

#Preview {
    MyPostsPostDetailView(viewModel: MyPostsPostViewModel(post: Post.DUMMY_POST))
}
