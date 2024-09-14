//
//  BackTitleModifier.swift
//  ShareBook
//
//  Created by 권형일 on 9/15/24.
//

import SwiftUI

struct BackTitleModifier: ViewModifier {
    @Environment(NavRouter.self) var navRouter: NavRouter
    var navigationTitle: String
    
    func body(content: Content) -> some View {
        content
            .toolbarBackground(Color.SBLightBlue, for: .navigationBar)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        navRouter.back()
                    } label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.medium)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(navigationTitle)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                }
            }
    }
}
