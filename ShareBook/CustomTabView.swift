//
//  CustomTabView.swift
//  ShareBook
//
//  Created by 권형일 on 8/4/24.
//

import SwiftUI

struct CustomTabView: View {
    @Environment(SelectedTabCapsule.self) var selectedTabCapsule
    
    private var fillImage: String {
        selectedTabCapsule.selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        @Bindable var selectedTabCapsule = selectedTabCapsule
        
        VStack {
            HStack {
                ForEach(MainTab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    
                    VStack {
                        Image(systemName: selectedTabCapsule.selectedTab == tab ? fillImage : tab.rawValue)
                            .scaleEffect(selectedTabCapsule.selectedTab == tab ? 1.25 : 1.0)
                            .foregroundStyle(selectedTabCapsule.selectedTab == tab ? Color(red: 112/255, green: 173/255, blue: 179/255) : .black)
                            .font(.system(size: 18))
//                            .shadow(color: Color(red: 112/255, green: 173/255, blue: 179/255).opacity(1.0), radius: selectedTab == tab ? 20 : 0, x: 0, y: 0)
                            .padding(.bottom, 1)
                            .padding(.top, 10)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 20, height: 5)
                            .foregroundStyle(Color(red: 112/255, green: 173/255, blue: 179/255))
                            .opacity(selectedTabCapsule.selectedTab == tab ? 1 : 0)
                            
                    }
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.4)) {
                            selectedTabCapsule.selectedTab = tab
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

enum MainTab: String, CaseIterable {
    case house = "house"
    case plusSquareOnSquare = "plus.square.on.square"
    case heart = "heart"
    case person = "person"
}

#Preview {
    CustomTabView()
        .environment(SelectedTabCapsule())
}
