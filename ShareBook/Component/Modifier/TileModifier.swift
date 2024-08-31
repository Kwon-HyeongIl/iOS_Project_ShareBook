//
//  TileModifier.swift
//  ShareBook
//
//  Created by 권형일 on 8/31/24.
//

import SwiftUI

struct TileModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
            .padding(.bottom, 10)
            .shadow(color: .gray.opacity(0.35), radius: 10, x: 5, y: 5)
    }
}

