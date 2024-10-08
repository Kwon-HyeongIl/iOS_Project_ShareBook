//
//  ButtonModifier.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

struct AuthViewButtonModifier: ViewModifier {
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 42)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
            .padding(.horizontal, 30)
    }
}
