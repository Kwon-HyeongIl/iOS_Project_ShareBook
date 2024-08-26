//
//  CustomTabView.swift
//  ShareBook
//
//  Created by 권형일 on 8/4/24.
//

import SwiftUI

struct MainCustomTabView: View {
    @Environment(SelectedMainTabCapsule.self) var selectedMainTabCapsule
    
    private var fillImage: String {
        selectedMainTabCapsule.selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        @Bindable var selectedMainTabCapsule = selectedMainTabCapsule
        
        VStack {
            HStack {
                ForEach(MainTab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    
                    VStack {
                        Image(systemName: selectedMainTabCapsule.selectedTab == tab ? fillImage : tab.rawValue)
                            .scaleEffect(selectedMainTabCapsule.selectedTab == tab ? 1.25 : 1.0)
                            .foregroundStyle(selectedMainTabCapsule.selectedTab == tab ? Color(red: 112/255, green: 173/255, blue: 179/255) : .black)
                            .font(.system(size: 18))
                            .padding(.bottom, 1)
                            .padding(.top, 10)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 20, height: 5)
                            .foregroundStyle(Color(red: 112/255, green: 173/255, blue: 179/255))
                            .opacity(selectedMainTabCapsule.selectedTab == tab ? 1 : 0)
                            
                    }
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.4)) {
                            selectedMainTabCapsule.selectedTab = tab
                        }
                    }
                    
                    Spacer()
                }
            }
            .frame(height: 70)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
            .padding()
        }
    }
}

#Preview {
    MainCustomTabView()
        .environment(SelectedMainTabCapsule())
}
