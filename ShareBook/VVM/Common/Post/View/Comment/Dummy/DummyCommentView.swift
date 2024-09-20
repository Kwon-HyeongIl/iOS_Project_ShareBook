//
//  DummyCommentView.swift
//  ShareBook
//
//  Created by 권형일 on 9/20/24.
//

import SwiftUI
import Shimmer

struct DummyCommentView: View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 32)
                .clipShape(Circle())
                .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
                .padding(.top)
                .padding(.leading, 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("DUMMY")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text("0일전")
                        .font(.system(size: 10))
                        .foregroundStyle(.gray)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .padding(.leading, 2)
                        .padding(.bottom, 1.5)
                    
                    Spacer()
                }
                
                Text("DUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMY")
                    .font(.system(size: 12))
            }
            .padding(.leading, 5)
            .padding(.vertical)
            
            Spacer()
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 10)
        .redacted(reason: .placeholder)
        .shimmering()
    }
}

#Preview {
    DummyCommentView()
}
