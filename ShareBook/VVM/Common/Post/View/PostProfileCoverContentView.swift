//
//  PostProfileCoverContentView.swift
//  ShareBook
//
//  Created by 권형일 on 8/31/24.
//

import SwiftUI
import Kingfisher

struct PostProfileCoverContentView: View {
    let post: Post
    
    var body: some View {
        ZStack {
            KFImage(URL(string: post.book.image))
                .resizable()
                .frame(width: 125, height: 175)
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
                    .frame(width: 13)
                
                Text("\(post.impressivePhrase)")
                    .fontWeight(.semibold)
                    .font(.system(size: 11))
                    .foregroundStyle(.white)
                    .lineLimit(7)
                    .truncationMode(.tail)
                    .padding(.horizontal, 5)
                
                Image(systemName: "quote.closing")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 13)
            }
            .frame(width: 125, height: 175)
        }
    }
}

#Preview {
    PostProfileCoverContentView(post: Post.DUMMY_POST)
}
