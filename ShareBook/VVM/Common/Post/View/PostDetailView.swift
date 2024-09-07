//
//  PostDetailView.swift
//  ShareBook
//
//  Created by 권형일 on 8/24/24.
//

import SwiftUI
import Kingfisher

struct PostDetailView: View {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
    @Bindable var viewModel: PostViewModel
    
    @Environment(SelectedMainTabCapsule.self) var selectedMainTabCapsule
    
    @Bindable var commentSheetCapsule: CommentSheetCapsule
    
    @State private var isFeelingCaptionExpanding = false
    @State private var isMoreOptionsSheetShowing = false
    
    var body: some View {
        GradientBackgroundView {
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            navStackControlTower.push(.ProfileView(viewModel.post.user, nil))
                        } label: {
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
                            }
                        }
                        
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
                    
                    BookCoverView(book: viewModel.post.book)
                        .padding(.vertical, 10)
                    
                    VStack {
                        Image(systemName: "quote.opening")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundStyle(Color.sBColor)
                            .padding(.top, 40)
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
                            .padding(.bottom, 40)
                        
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
                    .modifier(TileModifier())
                    
                    HStack(spacing: 5) {
                        Button {
                            Task {
                                await viewModel.isLike ? viewModel.unLike() : viewModel.like()
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
                            commentSheetCapsule.isCommentSheetShowing = true
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
                    .padding(.vertical)
                    .modifier(TileModifier())
                }
                
            }
            
        }
        .sheet(isPresented: $commentSheetCapsule.isCommentSheetShowing, onDismiss: {
            Task {
                await viewModel.loadAllPostCommentAndCommentReplyCount()
            }
        }, content: {
            CommentListView(post: viewModel.post)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.7), .large])
                .environment(commentSheetCapsule)
        })
        .sheet(isPresented: $isMoreOptionsSheetShowing) {
            MoreOptionsView(post: viewModel.post, isMoreOptionsSheetShowing: $isMoreOptionsSheetShowing)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.2), .large])
        }
        .modifier(BackButtonModifier())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navStackControlTower.popToRoot()
                    selectedMainTabCapsule.selectedTab = .house
                } label: {
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 23)
                        .foregroundStyle(Color.sBColor)
                        .padding(.trailing, 5)
                }
            }
        }
    }
}



#Preview {
    PostDetailView(viewModel: PostViewModel(post: Post.DUMMY_POST), commentSheetCapsule: CommentSheetCapsule())
        .environment(NavStackControlTower())
}
