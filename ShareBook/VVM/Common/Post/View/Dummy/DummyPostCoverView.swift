//
//  DummyPostCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 9/20/24.
//

import SwiftUI
import Shimmer

struct DummyPostCoverView: View {
    var isHotPost: Bool
    
    init(isHotPost: Bool) {
        self.isHotPost = isHotPost
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .opacity(0.6)
                    .frame(width: isHotPost ? 210 : 150, height: isHotPost ? 270 : 200)
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
                        .frame(width: isHotPost ? 15 : 13)
                    
                    Text("DUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMY")
                        .fontWeight(.semibold)
                        .font(.system(size: isHotPost ? 16 : 14))
                        .foregroundStyle(.white)
                        .lineLimit(7)
                        .truncationMode(.tail)
                        .padding(.horizontal)
                    
                    Image(systemName: "quote.closing")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: isHotPost ? 15 : 13)
                }
            }
            .padding(.top, 23)
            .padding(.bottom, 7)
            
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: isHotPost ? 19 : 15, height: isHotPost ? 19 : 15)
                        .clipShape(Circle())
                        .padding(.leading, 13)
                    
                    Text("DUMMY")
                        .font(.system(size: isHotPost ? 14 :  11))
                        .frame(width: 30, alignment: .leading)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .opacity(0.8)
                        .padding(.leading, 5)
                }
                
                Spacer()
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: isHotPost ? 15 : 12)
                    .foregroundStyle(Color.SBTitle)
                    .padding(.trailing, 3)
                
                Text("00")
                    .font(.system(size: isHotPost ? 13: 10))
                    .foregroundStyle(Color.SBTitle)
                    .padding(.trailing, 7)
                
                
                Image(systemName: "bubble.right")
                    .resizable()
                    .scaledToFill()
                    .frame(width: isHotPost ? 15 : 12)
                    .foregroundStyle(Color.SBTitle)
                    .padding(.trailing, 3)
                
                Text("00")
                    .font(.system(size: isHotPost ? 13 : 10))
                    .foregroundStyle(Color.SBTitle)
                    .padding(.trailing, 15)
            }
            .padding(.bottom, 20)
        }
        .frame(width: isHotPost ? 230 : 170, height: isHotPost ? 315 : 237)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .redacted(reason: .placeholder)
        .shimmering(bandSize: 0.4)
    }
}

#Preview {
    DummyPostCoverView(isHotPost: false)
}
