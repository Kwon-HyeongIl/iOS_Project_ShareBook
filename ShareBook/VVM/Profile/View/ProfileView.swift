//
//  ProfileView.swift
//  ShareBook
//
//  Created by 권형일 on 7/21/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            GradientBackgroundView {
                VStack {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color(red: 112/255, green: 173/255, blue: 179/255))
                            .frame(height: 300)
                            .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                        
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "bell")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.white)
                                    .padding(.trailing, 25)
                            }
                            
                            HStack {
                                Text("\(viewModel.user?.username ?? "")님")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 17)
                                Spacer()
                            }
                                
                            Text("오늘은 어떤 가치를 발견 하셨나요?")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 17)
                            
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(.thickMaterial)
                                    .frame(width: 360, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                                
                                HStack {
                                    if let profileImage = viewModel.profileImage {
                                        profileImage
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 50)
                                        
                                    } else if let imageUrl = viewModel.user?.profileImageUrl {
                                        KFImage(URL(string: imageUrl))
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 50)
                                        
                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 30)
                                    }

                                    
                                    VStack {
                                        Text("작성한 글")
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: 100)
                                        Text("n개")
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color(red: 112/255, green: 173/255, blue: 179/255))
                                    }
                                    
                                    VStack {
                                        Text("하트 누른 글")
                                            .fontWeight(.semibold)
                                        Text("n개")
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color(red: 112/255, green: 173/255, blue: 179/255))
                                    }
                                    .padding(.trailing, 5)
                                    .padding(.leading)
                                }
                            }
                            .padding()
                        }
                    }
                    
                    ScrollView {
                        NavigationLink {
                            ProfileEditView()
                        } label: {
                            HStack {
                                Image(systemName: "bookmark")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 27, height: 27)
                                    .padding(.leading, 5)
                                
                                Text("북마크한 책")
                                    .font(.system(size: 17, weight: .semibold))
                                    .padding(.leading, 5)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 10)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            AccountRelatedView()
                        } label: {
                            HStack {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .padding(.leading, 5)
                                
                                Text("계정 관련")
                                    .font(.system(size: 17, weight: .semibold))
                                    .padding(.leading, 5)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 10)

                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Image(systemName: "bell")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.leading, 5)
                                
                                Text("알림 설정")
                                    .font(.system(size: 17, weight: .semibold))
                                    .padding(.leading, 5)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 10)

                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Image(systemName: "speaker.wave.2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .padding(.leading, 5)
                                
                                Text("공지 사항")
                                    .font(.system(size: 17, weight: .semibold))
                                    .padding(.leading, 5)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 10)

                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                        }

                        Button {
                            viewModel.signout()
                        } label: {
                            Text("로그아웃")
                                .font(.system(size: 12))
                                .foregroundStyle(.blue)
                        }
                        .padding(.horizontal, 10)
                        .padding(.top, 20)
                    }
                    .tint(.black)
                    

                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
