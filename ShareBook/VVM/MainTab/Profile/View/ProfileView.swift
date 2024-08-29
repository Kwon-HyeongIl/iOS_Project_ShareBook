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
    @State var viewModel: ProfileViewModel
    
    @State var isUnFollowAlertShowing = false
    
    init(user: User?) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
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
                        if viewModel.isMyProfile == true {
                            HStack {
                                Text("내 프로필")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .shadow(color: .gray.opacity(0.7), radius: 10, x: 5, y: 5)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color.sBColor)
                                .opacity(0.6)
                                .frame(height: 330)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                            
                            VStack(spacing: 0) {
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
                                            .foregroundStyle(.black)
                                            .fontWeight(.semibold)
                                        
                                        Text("인문학")
                                            .font(.system(size: 14))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        navControlTower.push(.ProfileOptionView(viewModel.user))
                                    } label: {
                                        Image(systemName: "gearshape")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                            .padding(.trailing, 20)
                                            .padding(.bottom, 20)
                                    }
                                    
                                    
                                }
                                .padding(.top, 10)
                                .padding(.bottom)
                                
                                HStack(spacing: 60) {
                                    VStack(spacing: 3) {
                                        Text("기록한 구절")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                        
                                        Text("\(viewModel.posts.count)")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                    }
                                    
                                    VStack(spacing: 3) {
                                        Text("팔로워")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                        
                                        Text("\(viewModel.followerCount)")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                    }
                                    
                                    VStack(spacing: 3) {
                                        Text("팔로잉")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                        
                                        Text("\(viewModel.followingCount)")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                            .opacity(0.7)
                                    }
                                }
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                                
                                if viewModel.isMyProfile == true {
                                    Button {
                                        navControlTower.push(.ProfileEditView(viewModel.user))
                                    } label: {
                                        VStack {
                                            Text("프로필 편집")
                                                .font(.system(size: 15))
                                                .fontWeight(.semibold)
                                                .foregroundStyle(Color.sBColor)
                                        }
                                        .frame(height: 35)
                                        .frame(maxWidth: .infinity)
                                        .background(.thinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.sBColor, lineWidth: 1.0)
                                        }
                                        .padding(.horizontal, 50)
                                        .padding(.bottom, 10)
                                    }
                                    
                                } else {
                                    if viewModel.isFollow == true {
                                        Button {
                                            isUnFollowAlertShowing = true
                                        } label: {
                                            VStack {
                                                Text("팔로우 취소")
                                                    .font(.system(size: 15))
                                                    .fontWeight(.semibold)
                                                    .foregroundStyle(Color.sBColor)
                                            }
                                            .frame(height: 35)
                                            .frame(maxWidth: .infinity)
                                            .background(.thinMaterial)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.sBColor, lineWidth: 1.0)
                                            }
                                            .padding(.horizontal, 50)
                                            .padding(.bottom, 10)
                                        }
                                        .alert("정말 팔로우를 취소하시겠습니까?", isPresented: $isUnFollowAlertShowing) {
                                            Button(role: .cancel) {
                                                
                                            } label: {
                                                Text("취소")
                                            }
                                            
                                            Button(role: .destructive) {
                                                Task {
                                                    await viewModel.unFollow()
                                                }
                                            } label: {
                                                Text("계속")
                                            }
                                            
                                        } message: {
                                            
                                        }
                                        
                                    } else {
                                        Button {
                                            Task {
                                                await viewModel.follow()
                                            }
                                        } label: {
                                            VStack {
                                                Text("팔로우")
                                                    .font(.system(size: 15))
                                                    .fontWeight(.medium)
                                                    .foregroundStyle(.white)
                                            }
                                            .frame(height: 35)
                                            .frame(maxWidth: .infinity)
                                            .background(Color.sBColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .padding(.horizontal, 50)
                                            .padding(.bottom, 10)
                                        }
                                    }
                                }
                                
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
            .modifier(BackButtonModifier())
        }
    }
}

#Preview {
    ProfileView(user: User.DUMMY_USER)
        .environment(NavigationControlTower())
}
