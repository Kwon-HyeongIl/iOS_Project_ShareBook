//
//  NotificationsView.swift
//  ShareBook
//
//  Created by 권형일 on 9/14/24.
//

import SwiftUI

struct NotificationsView: View {
    @Environment(NavRouter.self) var navRouter: NavRouter
    @State private var viewModel = NotificationsViewModel()
    
    var body: some View {
        GradientBackgroundView {
            
        }
    }
}

#Preview {
    NotificationsView()
        .environment(NavRouter())
}
