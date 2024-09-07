//
//  CustomBackButtonModifier.swift
//  ShareBook
//
//  Created by 권형일 on 7/23/24.
//

import SwiftUI

struct BackButtonModifier: ViewModifier {
    @Environment(NavRouter.self) var navStackControlTower: NavRouter
//    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        navStackControlTower.back()
                    } label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.medium)
                    }
                }
            }
    }
}
