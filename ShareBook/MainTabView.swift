//
//  MainTabView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var controlTower = NavigationControlTower()
    @State private var selectedMainTabCapsule = SelectedMainTabCapsule()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationStack(path: $controlTower.paths) {
            ZStack {
                switch selectedMainTabCapsule.selectedTab {
                    
                case .house:
                    controlTower.navigate(to: .HomeView)
                    
                case .plusSquareOnSquare:
                    controlTower.navigate(to: .NewPostView)
                    
                case .heart:
                    controlTower.navigate(to: .LikeView)
                    
                case .person:
                    controlTower.navigate(to: .ProfileView)
                }
                
                VStack {
                    Spacer()
                    MainCustomTabView()
                }
            }
            .navigationDestination(for: Views.self) { view in
                controlTower.navigate(to: view)
            }
        }
        .environment(controlTower)
        .environment(selectedMainTabCapsule)
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}
