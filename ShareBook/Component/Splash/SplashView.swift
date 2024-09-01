//
//  SplashView.swift
//  ShareBook
//
//  Created by 권형일 on 7/24/24.
//

import SwiftUI
import Shimmer

struct SplashView: View {
    var body: some View {
        GradientBackgroundView {
            Image("ShareBook_TextLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .shimmering()
        }
    }
}

#Preview {
    SplashView()
}
