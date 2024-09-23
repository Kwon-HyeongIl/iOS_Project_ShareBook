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
        ZStack {
            LinearGradient(stops: [
                Gradient.Stop(color: Color(red: 222/255, green: 250/255, blue: 252/255), location: 0.1),
                Gradient.Stop(color: Color(red: 207/255, green: 220/255, blue: 230/255), location: 0.6),
                Gradient.Stop(color: Color(red: 197/255, green: 224/255, blue: 208/255), location: 1)
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(edges: .vertical)
            
            VStack(spacing: 0) {
                Image("Icon_Raw")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Image("ShareBook_TextLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .shimmering(animation: .easeInOut(duration: 1.5))
                    .padding(.bottom, 30)
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    SplashView()
}
