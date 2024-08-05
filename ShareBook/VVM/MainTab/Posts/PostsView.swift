//
//  PostsView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI

struct PostsView: View {
    var body: some View {
        NavigationStack {
            GradientBackgroundView {
                VStack {
                    Image("ShareBook_TextLogo")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .frame(width: 100)
                    
                    ScrollView {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    PostsView()
}
