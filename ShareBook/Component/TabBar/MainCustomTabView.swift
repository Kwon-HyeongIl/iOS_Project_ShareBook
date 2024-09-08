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
        
//        VStack {
            HStack {
                ForEach(MainTab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    
                    VStack {
                        Image(systemName: mainTabCapsule.selectedTab == tab ? fillImage : tab.rawValue)
                            .scaleEffect(mainTabCapsule.selectedTab == tab ? 1.25 : 1.0)
                            .foregroundStyle(mainTabCapsule.selectedTab == tab ? Color(red: 112/255, green: 173/255, blue: 179/255) : .black)
                            .font(.system(size: 18))
                            .padding(.bottom, 1)
                            .padding(.top, 10)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 20, height: 5)
                            .foregroundStyle(Color(red: 112/255, green: 173/255, blue: 179/255))
                            .opacity(mainTabCapsule.selectedTab == tab ? 1 : 0)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            mainTabCapsule.selectedTab = tab
                        }
                    }
                    
                    Spacer()
                }
            }
            .background(.ultraThinMaterial)
//        }
    }
}

#Preview {
    MainCustomTabView()
        .environment(MainTabCapsule())
}
