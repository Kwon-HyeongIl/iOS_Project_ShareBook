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
            VStack {
                ZStack {
                    Image("Icon_Raw")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Image("ShareBook_TextLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280)
                        .padding(.top, 250)
                        .shimmering()
                }
                .padding(.bottom, 100)
            }
        }
    }
}

#Preview {
    SplashView()
}
