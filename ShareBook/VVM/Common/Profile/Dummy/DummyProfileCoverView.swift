//
//  DummyProfileCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import SwiftUI
import Shimmer

struct DummyProfileCoverView: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 45, height: 45)
                .opacity(0.3)
                .padding(.trailing, 10)
                .padding(.leading)
            
            VStack {
                Text("DUMMYDUMMY")
                    .fontWeight(.medium)
                
                Text("DUMMY")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .opacity(0.6)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 10)
                .fontWeight(.medium)
                .padding(.trailing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .redacted(reason: .placeholder)
        .shimmering()
    }
}

#Preview {
    DummyProfileCoverView()
}
