//
//  SearchView.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import SwiftUI

struct NewPostView: View {
    @Environment(NavigationRouter.self) var navRouter: NavigationRouter
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                ZStack {
                    Image("ShareBook_TextLogo")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Rectangle())
                        .opacity(0.3)
                        .frame(width: 310)
                        .padding(.top, 30)
                        .blur(radius: 2)
                    
                    ZStack {
                        Girl3DView()
                        
                        Image(systemName: "bubble.middle.bottom.fill")
                            .resizable()
                            .frame(width: 260, height: 100)
                            .foregroundStyle(.white.opacity(0.8))
                            .overlay {
                                Text("오늘은 어떤 가치를 발견 하셨나요?")
                                    .font(.system(size: 15))
                                    .modifier(ItalicFontModifier())
                                    .padding(.bottom)
                            }
                            .padding(.bottom, 350)
                    }
                    .padding(.top, 80)  
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        navRouter.navigate(.SearchBookView)
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.SBTitle)
                                .opacity(0.8)
                                .padding(.leading, 10)
                            
                            Text("등록할 책을 검색하세요")
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .opacity(0.8)
                        }
                        .frame(width: max(0, proxy.size.width - 25))
                        .frame(height: 38)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.SBTitle, lineWidth: 1)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewPostView()
        .environment(NavigationRouter())
}
