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
                        KFImage(URL(string: viewModel.post.user.profileImageUrl ?? ""))
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .overlay {
                                Circle()
                                    .stroke(Color.sBColor, lineWidth: 2)
                            }
                            .padding(.leading, 20)
                        
                        Text("\(viewModel.post.user.username)")
                            .fontWeight(.semibold)
                        
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
                            .padding(.bottom, 20)

                        Text("\(viewModel.post.impressivePhrase)")
                            .fontWeight(.semibold)
                        
                        Image(systemName: "quote.closing")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30)
                            .foregroundStyle(Color.sBColor)
                            .padding(.top, 20)
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
                                        .font(.system(size: 15))
                                        .padding(.bottom, 5)
                                    
                                    Image(systemName: "chevron.down")
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
                    
                    HStack {
                        Image(systemName: "heart")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30)
                            .foregroundStyle(Color.sBColor)
                            .padding(.leading, 30)
                        
                        Button {
                            isCommentSheetShowing = true
                        } label: {
                            Image(systemName: "bubble.right")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30)
                                .foregroundStyle(Color.sBColor)
                        }
                        
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                
            }
            
        }
        .sheet(isPresented: $isCommentSheetShowing, content: {
            CommentView(post: viewModel.post)
                .presentationDragIndicator(.visible)
        })
        .modifier(BackButtonModifier())
    }
}

#Preview {
    HomePostDetailView(viewModel: HomePostViewModel(post: Post.DUMMY_POST))
}
