//
//  LikesHeadTabView.swift
//  ShareBook
//
//  Created by 권형일 on 8/23/24.
//

import SwiftUI

struct LikesHeadTabView: View {
    @Binding var selectedTab: LikeTab
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(LikeTab.allCases, id: \.self) { tab in
                VStack(spacing: 0) {
                    Text("\(tab.rawValue)")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(selectedTab == tab ? Color.sBColor : .primary)
                        .opacity(selectedTab == tab ? 1.0 : 0.7)
                        .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                        .padding(.bottom, 10)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 4)
                        .foregroundStyle(Color.sBColor)
                        .opacity(selectedTab == tab ? 1.0 : 0)
                    
                    Divider()
                }
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.4)) {
                        selectedTab = tab
                    }
                }
            }
        }
    }
}



#Preview {
    LikesHeadTabView(selectedTab: .constant(.likePosts))
}
