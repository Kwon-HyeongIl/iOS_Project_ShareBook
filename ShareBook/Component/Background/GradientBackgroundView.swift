//
//  GradientBackgroundView.swift
//  ShareBook
//
//  Created by 권형일 on 7/22/24.
//

import SwiftUI

struct GradientBackgroundView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                Gradient.Stop(color: Color(red: 222/255, green: 250/255, blue: 252/255), location: 0.1),
                Gradient.Stop(color: Color(red: 207/255, green: 220/255, blue: 230/255), location: 0.6),
                Gradient.Stop(color: Color(red: 197/255, green: 224/255, blue: 208/255), location: 1)
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(edges: .vertical)
            .opacity(0.5)
            
            content
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    GradientBackgroundView {
        Text("")
    }
}
