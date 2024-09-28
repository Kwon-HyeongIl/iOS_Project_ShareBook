//
//  ProfileCoverContentView.swift
//  ShareBook
//
//  Created by 권형일 on 9/28/24.
//

import SwiftUI
import Kingfisher

struct ProfileCoverContentView: View {
    let user: User?

    var body: some View {
        HStack {
            if let imageUrl = user?.profileImageUrl {
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                    .padding(.leading)
                
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .opacity(0.8)
                    .padding(.trailing, 10)
                    .padding(.leading)
            }
            
            VStack {
                Text("\(user?.username ?? "")")
                    .fontWeight(.medium)
                
                Text("\(user?.titleGenre?.rawValue ?? "")")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .padding(.leading, 3)
                    .opacity(0.6)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 10)
                .fontWeight(.medium)
                .padding(.trailing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
    }
}

#Preview {
    ProfileCoverContentView(user: User.DUMMY_USER)
}
