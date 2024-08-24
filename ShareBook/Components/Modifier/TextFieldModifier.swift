//
//  TextFieldModifier.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .padding(12)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
                    .opacity(0.35)
            }
            .frame(width: 353, height: 42)
    }
}
