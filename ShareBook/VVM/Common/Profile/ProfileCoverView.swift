//
//  ProfileCoverView.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import SwiftUI

struct ProfileCoverView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    let user: User?
    
    var body: some View {
        Button {
//            navRouter.navigate(.BookDetailView(viewModel))
        } label: {
            ProfileCoverContentView(user: user)
        }
    }
}

#Preview {
    ProfileCoverView(user: nil)
}
