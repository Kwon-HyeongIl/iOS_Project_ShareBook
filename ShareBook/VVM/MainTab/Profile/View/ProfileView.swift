//
//  ProfileView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @Environment(NavigationControlTower.self) var navControlTower: NavigationControlTower
    @State var viewModel = ProfileViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        GeometryReader { proxy in
            GradientBackgroundView {
                ScrollView {
                    VStack(spacing: 5) {
                        HStack {
                            Text("내 프로필")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color.sBColor)
                                .opacity(0.6)
                                .frame(height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack {
                                HStack {
                                    if let profileImage = viewModel.profileImage {
                                        profileImage
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 10)
                                            .padding(.leading)
                                        
                                    } else if let imageUrl = viewModel.user?.profileImageUrl {
                                        KFImage(URL(string: imageUrl))
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 10)
                                            .padding(.leading)
                                        
                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 10)
                                            .padding(.leading)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("\(viewModel.user?.username ?? "유저네임")")
                                            .font(.system(size: 18))
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                            .opacity(0.7)
                                        
                                        Text("인문학")
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                            .opacity(0.7)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "gearshape")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25)
                                        .foregroundStyle(.white)
                                        .padding(.trailing, 20)
                                        .padding(.bottom, 20)
                                    
                                }
                                .padding(.bottom)
                                
                                HStack(spacing: 60) {
                                    VStack(spacing: 3) {
                                        Text("기록한 구절")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                        
                                        Text("10")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                    }
                                    
                                    VStack(spacing: 3) {
                                        Text("팔로워")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                        
                                        Text("10")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                    }
                                    
                                    VStack(spacing: 3) {
                                        Text("팔로잉")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                        
                                        Text("10")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                    }
                                }
                                .padding(.bottom, 10)
                                
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundStyle(.thickMaterial)
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                                    
                                    HStack {
                                        
                                    }
                                }
                                .padding()
                            }
                        }
                        
                        LazyVGrid(columns: columns, spacing: viewModel.calSizeBase4And393(proxyWidth: proxy.size.width)) {
                            ForEach(viewModel.posts) { post in
                                navControlTower.navigate(to: .PostProfileCoverView(post))
                                    .scaleEffect(viewModel.calSizemBase1And393(proxyWidth: proxy.size.width))
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environment(NavigationControlTower())
}
