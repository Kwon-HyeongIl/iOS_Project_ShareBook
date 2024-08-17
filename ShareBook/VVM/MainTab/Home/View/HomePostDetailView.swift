//
//  PostDetailView.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import SwiftUI
import Kingfisher

struct HomePostDetailView: View {
    @Bindable var viewModel: HomePostViewModel
    
    @State var isFeelingCaptionExpanding = false
    @State var isCommentSheetShowing = false
    
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
                                .overlay {
                                    Circle()
                                        .stroke(Color.sBColor, lineWidth: 2)
                                }
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
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                            .padding(.leading, 5)
                        
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
                            withAnimation {
                                isFeelingCaptionExpanding.toggle()
                            }
                        } label: {
                            VStack {
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
                                    .font(.system(size: 15))
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
                                    .font(.system(size: 15))
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
                            .font(.system(size: 15))
                            .padding(.trailing)
                        
                    }
                    .padding(.vertical, 15)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                }
                
            }
            
        }
        .sheet(isPresented: $isCommentSheetShowing, onDismiss: {
            Task {
                await viewModel.loadPostCommentCount()
            }
        }, content: {
            CommentView(post: viewModel.post)
                .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.7), .large])
        })
        .modifier(BackButtonModifier())
    }
}

#Preview {
    HomePostDetailView(viewModel: HomePostViewModel(post: Post.DUMMY_POST))
}
