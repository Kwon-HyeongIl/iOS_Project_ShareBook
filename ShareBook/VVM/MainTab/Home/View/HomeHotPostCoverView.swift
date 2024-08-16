//
//  PostCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 8/12/24.
//

import SwiftUI
import Kingfisher

struct HomeHotPostCoverView: View {
    @State private var viewModel: HomePostViewModel
    
    init(post: Post) {
        self.viewModel = HomePostViewModel(post: post)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink {
                HomePostDetailView(viewModel: viewModel)
            } label: {
                ZStack {
                    KFImage(URL(string: viewModel.post.book.image))
                        .resizable()
                        .frame(width: 190, height: 255)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .blur(radius: 3.0)
                    
                    Text("\(viewModel.post.impressivePhrase)")
                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                        .foregroundStyle(.white)
                        .lineLimit(7)
                        .truncationMode(.tail)
                        .padding(.horizontal)
                }
                .padding(.top, 40)
                .padding(.bottom, 10)
            }
            
            HStack(spacing: 0) {
                if let profileImageUrl = viewModel.post.user.profileImageUrl {
                    KFImage(URL(string: profileImageUrl))
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(Color.sBColor, lineWidth: 2)
                        }
                        .padding(.leading, 27)
                        
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                        .padding(.leading, 27)
                }
                
                Text("\(viewModel.post.user.username)")
                    .font(.system(size: 13))
                    .frame(width: 50, alignment: .leading)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.leading, 7)
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.isLike ? viewModel.unlike() : viewModel.like()
                    }
                } label: {
                    Image(systemName: viewModel.isLike ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 16)
                        .foregroundStyle(Color.sBColor)
                }
                .padding(.trailing, 3)
                
                Text("\(viewModel.post.like)")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.sBColor)
                    .padding(.trailing, 10)
                
                Button {
                    
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 16)
                        .foregroundStyle(Color.sBColor)
                }
                .padding(.trailing, 3)
                
                Text("\(viewModel.commentCount)")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.sBColor)
                    .padding(.trailing, 25)
            }
            .padding(.bottom, 30)
        }
        .frame(width: 225, height: 310)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 5)
        .padding(.vertical)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
    }
}


#Preview {
    HomeHotPostCoverView(post: Post.DUMMY_POST)
}
