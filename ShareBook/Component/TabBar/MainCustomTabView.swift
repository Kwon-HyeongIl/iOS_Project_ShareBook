//
//  MainCustomTabView.swift
//  ShareBook
//
//  Created by 권형일 on 9/8/24.
//

import SwiftUI

struct MainCustomTabView: View {
    @Environment(MainTabCapsule.self) var mainTabCapsule
    
    private var fillImage: String {
        mainTabCapsule.selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        @Bindable var mainTabCapsule = mainTabCapsule
        
        HStack {
            ForEach(MainTab.allCases, id: \.rawValue) { tab in
                Spacer()
                
                VStack {
                    Image(systemName: mainTabCapsule.selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(mainTabCapsule.selectedTab == tab ? 1.25 : 1.0)
                        .foregroundStyle(mainTabCapsule.selectedTab == tab ? Color.SBTitle : .black)
                        .font(.system(size: 19))
                        .padding(.bottom, 1)
                        .padding(.top, 10)
                    
                    Text(tab.title)
                        .font(.system(size: 9))
                        .foregroundStyle(mainTabCapsule.selectedTab == tab ? Color.SBTitle : .black)
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        mainTabCapsule.selectedTab = tab
                    }
                }
                .padding(.bottom, 5)
                
                Spacer()
            }
        }
        .frame(height: 50)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    MainCustomTabView()
        .environment(MainTabCapsule())
}
