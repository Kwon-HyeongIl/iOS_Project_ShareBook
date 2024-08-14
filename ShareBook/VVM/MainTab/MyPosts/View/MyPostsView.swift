//
//  MyPostsView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct MyPostsView: View {
    @State var viewModel = MyPostsViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Text("내가 작성한 글")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                ScrollView(.horizontal) {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 90, height: 30)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                            
                            Text("인문학")
                                .foregroundStyle(Color.sBColor)
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 90, height: 30)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                            
                            Text("경제학")
                                .foregroundStyle(Color.sBColor)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(viewModel.posts) { post in
                            MyPostsPostCoverView(post: post)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MyPostsView()
}
