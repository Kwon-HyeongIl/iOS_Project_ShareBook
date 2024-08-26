//
//  MainTabView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var coordinator = NavigationCoordinator()
    
    @State private var selectedTabCapsule = SelectedTabCapsule()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.paths) {
            ZStack {
                switch selectedTabCapsule.selectedTab {
                    
                case .house:
                    HomeView()
                    
                case .plusSquareOnSquare :
                    coordinator.navigate(to: .NewPostView)
                        .navigationDestination(for: Views.self) { view in
                            coordinator.navigate(to: view)
                        }
                    
                case .heart:
                    LikesView()
                    
                case .person:
                    ProfileView()
                }
                
                VStack {
                    Spacer()
                    MainCustomTabView()
                }
            }
        }
        .environment(coordinator)
        .environment(selectedTabCapsule)
        .tint(.black)
    }
}

@Observable
class SelectedTabCapsule {
    var selectedTab: MainTab = .house
}

#Preview {
    MainTabView()
}
