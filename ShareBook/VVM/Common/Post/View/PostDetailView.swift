//
//  PostDetailView.swift
//  ShareBook
//
//  Created by 권형일 on 8/24/24.
//

import SwiftUI
import Kingfisher

struct PostDetailView: View {
    @Environment(NavigationControlTower.self) var navControlTower: NavigationControlTower
    @Bindable var viewModel: PostViewModel
    
    @State var isFeelingCaptionExpanding = false
    
    @State var isCommentSheetShowing = false
    @State var isMoreOptionsSheetShowing = false
    
    @State var isDeletePost = false
    
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
                        
                        Button {
                            isMoreOptionsSheetShowing = true
                        } label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundStyle(.black)
                                .padding(.trailing, 25)
                        }
                    }
                    
                    navControlTower.navigate(to: .BookCoverView(viewModel.post.book))
                        .padding(.vertical, 10)
                    
                    VStack {
                        Image(systemName: "quote.opening")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundStyle(Color.sBColor)
                            .padding(.top, 50)
                            .padding(.bottom, 30)
                        
                        Text("\(viewModel.post.impressivePhrase)")
                            .multilineTextAlignment(.center)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "quote.closing")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
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
                    .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
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
                                    .fontWeight(.semibold)
                                    .padding(.leading)
                                
                                Text("좋아요")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                    .padding(.leading, 3)
                                
                                Text("\(viewModel.post.likeCount)")
                                    .font(.system(size: 13))
                                    .fontWeight(.semibold)
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
                                    .fontWeight(.semibold)
                                    .padding(.leading, 10)
                                
                                Text("댓글")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                    .padding(.leading, 3)
                                
                                Text("\(viewModel.commentCount)")
                                    .font(.system(size: 13))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                        }
                        
                        Spacer()
                        
                        Image(systemName: "book")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.sBColor)

                        Text("\(viewModel.post.genre.rawValue)")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .padding(.leading, 3)
                            .padding(.trailing)
                            
                    }
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
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
        .sheet(isPresented: $isMoreOptionsSheetShowing) {
            MoreOptionsView(post: viewModel.post, isDeletePost: $isDeletePost)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.2), .large])
        }
        .onChange(of: isDeletePost) {
            navControlTower.pop()
        }
        .modifier(BackButtonModifier())
    }
}

#Preview {
    PostDetailView(viewModel: PostViewModel(post: Post.DUMMY_POST))
        .environment(NavigationControlTower())
}
