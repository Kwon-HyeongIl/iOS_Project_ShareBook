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
        VStack {
            NavigationLink {
                HomePostDetailView(viewModel: viewModel)
            } label: {
                ZStack {
                    KFImage(URL(string: viewModel.post.book.image))
                        .resizable()
                        .frame(width: 210, height: 270)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .blur(radius: 3.0)
                    
                    Text("\(viewModel.post.impressivePhrase)")
                        .fontWeight(.semibold)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .lineLimit(7)
                        .truncationMode(.tail)
                        .padding(.horizontal)
                }
                .padding(.top, 40)
            }
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: viewModel.isLike ? "heart.fill" : "heart")
                        .foregroundStyle(Color.sBColor)
                }
                .padding(.leading, 35)
                
                Button {
                    
                } label: {
                    Image(systemName: "bubble.right")
                        .foregroundStyle(Color.sBColor)
                }
                
                Spacer()
                
                Text("\(viewModel.post.user.username)")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.sBColor)
                    .frame(width: 70, alignment: .trailing)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.trailing, 35)
            }
            .padding(.top, 1)
            .padding(.bottom, 25)
        }
        .frame(width: 260, height: 330)
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
