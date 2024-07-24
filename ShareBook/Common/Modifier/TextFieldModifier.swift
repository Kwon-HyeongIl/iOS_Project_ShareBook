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
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.gray, lineWidth: 1)
            }
            .frame(width: 363, height: 42)
    }
}
