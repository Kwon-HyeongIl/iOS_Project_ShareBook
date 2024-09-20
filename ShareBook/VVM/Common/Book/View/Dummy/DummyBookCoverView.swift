//
//  DummyBookCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 9/20/24.
//

import SwiftUI
import Shimmer

struct DummyBookCoverView: View {
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .opacity(0.4)
                    .frame(width: 90, height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .padding(.leading)
                Spacer()
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("DUMMYDUMMY")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .truncationMode(.tail)
                        .frame(width: 200, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Text("DUMMY")
                        .font(.system(size: 14))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(width: 150, alignment: .leading)
                    
                    Text("0000.00.00")
                        .font(.system(size: 13))
                        .foregroundStyle(.gray)
                }
                .padding(.trailing, 10)
            }
            .frame(height: 160)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
            .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
        }
        .redacted(reason: .placeholder)
        .shimmering()
    }
}

#Preview {
    DummyBookCoverView()
}
