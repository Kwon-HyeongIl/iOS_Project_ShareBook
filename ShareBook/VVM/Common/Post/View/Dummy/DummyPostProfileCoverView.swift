//
//  DummyPostProfileCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 9/20/24.
//

import SwiftUI
import Shimmer

struct DummyPostProfileCoverView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .opacity(0.1)
                .frame(width: 125, height: 175)
                .clipShape(RoundedRectangle(cornerRadius: 10))
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
                
                Text("DUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMY")
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
        .redacted(reason: .placeholder)
        .shimmering()
    }
}

#Preview {
    DummyPostProfileCoverView()
}
