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
    
    var body: some View {
        GradientBackgroundView {
            VStack {
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
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                    
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
                                    .fontWeight(.semibold)
                                    .opacity(0.7)
                                
                                Text("인문학")
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .opacity(0.7)
                                
                            }
                            
                            Spacer()
                            
                            Image(systemName: "gearshape")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .foregroundStyle(.white)
                                .padding(.trailing, 20)
                            
                        }
                        .padding(.bottom)
                        
                        HStack(spacing: 60) {
                            VStack(spacing: 3) {
                                Text("기록한 책")
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
                
                Spacer()
                
                Button {
                    viewModel.signout()
                } label: {
                    Text("로그아웃")
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environment(NavigationControlTower())
}
