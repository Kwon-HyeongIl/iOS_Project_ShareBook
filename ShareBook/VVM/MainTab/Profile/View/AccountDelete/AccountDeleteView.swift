//
//  AccountDeleteView.swift
//  ShareBook
//
//  Created by 권형일 on 10/3/24.
//

import SwiftUI

struct AccountDeleteView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(NavRouter.self) var navRouter: NavRouter
    @Environment(MainTabCapsule.self) var mainTabCapsule
    @State private var viewModel = AccountDeleteViewModel()
    
    @State private var isAccountDeleteAlertShowing = false
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Text("계정을 삭제할 경우 계정과 관련된 모든 데이터가 삭제되며, 복구할 수 없습니다.")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom)
                
                Text("삭제")
                    .modifier(InViewButtonModifier(bgColor: .SBTitle))
                    .alert("정말 삭제 하시겠습니까?", isPresented: $isAccountDeleteAlertShowing) {
                        Button(role: .cancel) {
                            
                        } label: {
                            Text("취소")
                        }
                        
                        Button(role: .destructive) {
                            withAnimation(.easeOut(duration: 0.4)) {
                                viewModel.deleteAccount()
                            }
                            navRouter.popToRoot()
                            mainTabCapsule.selectedTab = .house
                            
                            appDelegate.refreshDeviceToken()
                        } label: {
                            Text("계속")
                        }
                    }
                
                Spacer()
            }
        }
        .modifier(BackTitleModifier(navigationTitle: "계정 삭제"))
    }
}

#Preview {
    AccountDeleteView()
        .environment(NavRouter())
        .environment(MainTabCapsule())
}
