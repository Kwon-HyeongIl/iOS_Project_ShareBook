//
//  CustomBackButtonModifier.swift
//  ShareBook
//
//  Created by 권형일 on 7/23/24.
//

import SwiftUI

struct BackButtonModifier: ViewModifier {
    @Environment(NavStackControlTower.self) var navStackControlTower: NavStackControlTower
//    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        navStackControlTower.pop()
                    } label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.medium)
                    }
                }
            }
    }
}
