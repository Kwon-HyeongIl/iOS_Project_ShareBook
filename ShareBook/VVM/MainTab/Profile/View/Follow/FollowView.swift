//
//  FollowView.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import SwiftUI

struct FollowView: View {
    let user: User?
    
    @State private var selectedTab: FollowTab
    
    // 뷰 캐싱
    @State private var followerView: FollowerView
    @State private var followingView: FollowingView
    
    init(type: FollowTab, user: User?) {
        if type == .follower {
            self.selectedTab = .follower
        } else {
            self.selectedTab = .following
        }
        
        self.user = user
        
        self.followerView = FollowerView(user: user)
        self.followingView = FollowingView(user: user)
    }
    
    var body: some View {
        GradientBackgroundView {
            VStack(spacing: 0) {
                FollowTabView(selectedTab: $selectedTab)
            
                ScrollView {
                    switch selectedTab {
                        
                    case .follower:
                        followerView
                        
                    case .following:
                        followingView
                    }
                }
            }
        }
        .modifier(BackTitleModifier(navigationTitle: "\(user?.username ?? "")"))
    }
}

#Preview {
    FollowView(type: .follower, user: nil)
}
