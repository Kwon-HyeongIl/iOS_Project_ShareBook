//
//  CustomBackButtonModifier.swift
//  ShareBook
//
//  Created by 권형일 on 7/23/24.
//

import SwiftUI

struct BackModifier: ViewModifier {
    @Environment(NavRouter.self) var navRouter: NavRouter
    
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
            }
    }
}
