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
                            
                            Text("\(viewModel.user?.username ?? "")님")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                
                            Text("오늘은 책에서 어떤 가치를 발견 하셨나요?")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                            ZStack {
                                Rectangle()
                                    .foregroundStyle(.thickMaterial)
                                    .frame(width: 350, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 5, y: 5)
                                
                                HStack {
                                    
                                    if let profileImage = viewModel.profileImage {
                                        profileImage
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 40)
                                        
                                    } else if let imageUrl = viewModel.user?.profileImageUrl {
                                        KFImage(URL(string: imageUrl))
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 40)
                                        
                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .padding(.trailing, 40)
                                    }

                                    
                                    VStack {
                                        Text("작성한 글")
                                            .fontWeight(.semibold)
                                        Text("n개")
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color(red: 112/255, green: 173/255, blue: 179/255))
                                    }
                                    .padding(.trailing, 50)
                                    
                                    VStack {
                                        Text("북마크")
                                            .fontWeight(.semibold)
                                        Text("n개")
                                            .fontWeight(.semibold)
                                            .foregroundStyle(Color(red: 112/255, green: 173/255, blue: 179/255))
                                    }
                                    .padding(.trailing, 5)
                                }
                            }
                            .padding()
                        }
                    }
                    
                    VStack {
                        NavigationLink {
                            ProfileEditView()
                        } label: {
                            HStack {
                                Text("프로필 수정")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.leading, 10)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 10)
                            }
                            .padding()
                            
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Text("로그인 방식 변경")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.leading, 10)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 10)

                            }
                            .padding()
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Text("공지사항")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.leading, 10)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 10)

                            }
                            .padding()
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Text("알림 설정")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.leading, 10)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 10)

                            }
                            .padding()
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        NavigationLink {
                            
                        } label: {
                            HStack {
                                Text("계정 관련")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding(.leading, 10)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .padding(.trailing, 10)

                            }
                            .padding()
                        }

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
