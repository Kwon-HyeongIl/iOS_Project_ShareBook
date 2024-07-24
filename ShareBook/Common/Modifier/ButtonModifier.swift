//
//  ButtonModifier.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(width: 363, height: 42)
            .background(Color(red: 112/255, green: 173/255, blue: 179/255))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
    }
}
