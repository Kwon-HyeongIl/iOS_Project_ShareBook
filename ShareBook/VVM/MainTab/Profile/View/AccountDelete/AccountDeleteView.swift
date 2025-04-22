//
//  AccountDeleteView.swift
//  ShareBook
//
//  Created by 권형일 on 10/3/24.
//

import SwiftUI

struct AccountDeleteView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    @Environment(MainTabCapsule.self) var mainTabCapsule
    @State private var viewModel = AccountDeleteViewModel()
    
    @State private var isAccountDeleteAlertShowing = false
    
    var body: some View {
        GradientBackgroundView {
            VStack {
                Image(systemName: "person.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .padding(.top)

                Text("계정을 삭제할 경우 복구할 수 없으며, 작성하신 글과 댓글들은 자동으로 삭제되지 않습니다.")
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom)
                
                Button {
                    isAccountDeleteAlertShowing = true
                } label: {
                    Text("삭제")
                        .modifier(InViewButtonModifier(bgColor: .SBTitle))
                }
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
        .environment(NavigationRouter())
        .environment(MainTabCapsule())
}
