//
//  AccountRelatedView.swift
//  ShareBook
//
//  Created by 권형일 on 7/31/24.
//

import SwiftUI

struct AccountRelatedView: View {
    var body: some View {
        GradientBackgroundView {
            VStack {
                Text("계정 관련")
                    .font(.title)
                    .fontWeight(.semibold)
                
                ScrollView {
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Text("프로필 정보 수정")
                                .foregroundStyle(.black)
                                .font(.system(size: 17, weight: .semibold))
                                .padding(.leading, 10)
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
                        SocialLoginEditView()
                    } label: {
                        HStack {
                            Text("간편 로그인 설정")
                                .foregroundStyle(.black)
                                .font(.system(size: 17, weight: .semibold))
                                .padding(.leading, 10)
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                                .padding(.trailing, 10)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    AccountRelatedView()
}
