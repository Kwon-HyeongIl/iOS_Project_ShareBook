//
//  ItalicFontModifier.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

// 한글에 이탤릭체 적용
struct ItalicFontModifier: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .transformEffect(CGAffineTransform(a: 1, b: 0, c: -CGFloat(tanf(12 * .pi / 180)), d: 1, tx: 0, ty: 0))
                .foregroundStyle(.gray)
        }
}
