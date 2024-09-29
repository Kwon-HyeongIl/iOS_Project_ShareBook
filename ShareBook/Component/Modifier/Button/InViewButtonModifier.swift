//
//  InViewButtonModifier.swift
//  ShareBook
//
//  Created by 권형일 on 8/30/24.
//

import SwiftUI

struct InViewButtonModifier: ViewModifier {
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(width: 110, height: 34)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
            .padding(.bottom)
    }
}
