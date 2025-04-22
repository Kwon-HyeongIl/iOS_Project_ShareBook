//
//  NavigationBaseView.swift
//  ShareBook
//
//  Created by 권형일 on 4/22/25.
//

import SwiftUI

struct NavigationBaseView: View {
    @State private var navRouter = NavigationRouter()
    @State private var mainTabCapsule = MainTabCapsule()
    @State private var signupViewModel = SignupViewModel()
    @State private var isPostAddedCapsule = IsPostAddedCapsule()
    
    var body: some View {
        NavigationStack(path: $navRouter.path) {
            AisleView()
                .navigationDestination(for: NavStackView.self) { view in
                    navRouter.destinationNavigate(to: view)
                }
                .preferredColorScheme(.light)
        }
        .environment(navRouter)
        .environment(mainTabCapsule)
        .environment(signupViewModel)
        .environment(isPostAddedCapsule)
    }
}

#Preview {
    NavigationBaseView()
}
