//
//  DummyProfileView.swift
//  ShareBook
//
//  Created by 권형일 on 9/23/24.
//

import SwiftUI

struct DummyProfileView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.SBTitle)
                .opacity(0.6)
                .frame(height: 340)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
            
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .opacity(0.8)
                        .padding(.trailing, 10)
                        .padding(.leading)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("DUMMYDUMMY")
                            .font(.system(size: 18))
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                        
                        Text("DUMMY")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .opacity(0.6)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 14)
                
                VStack {
                    HStack(spacing: 60) {
                        VStack(spacing: 3) {
                            Text("DUMMY")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .opacity(0.7)
                            
                            Text("000")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .opacity(0.7)
                        }
                        
                        VStack(spacing: 3) {
                            Text("DUMMY")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .opacity(0.7)
                            
                            Text("000")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .opacity(0.7)
                        }
                        
                        VStack(spacing: 3) {
                            Text("DUMMY")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .opacity(0.7)
                            
                            Text("000")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                                .opacity(0.7)
                        }
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                    
                    VStack {
                        Text("프로필 편집")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.SBTitle)
                    }
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.SBTitle, lineWidth: 1.0)
                    }
                    .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                    .padding(.horizontal, 40)
                }
                .frame(height: 120)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                ZStack {
                    Rectangle()
                        .foregroundStyle(.regularMaterial)
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 5, y: 5)
                        .padding(.horizontal)
                    
                    HStack {
                        Rectangle()
                            .frame(width: 60, height: 85)
                            .opacity(0.2)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .padding(.leading, 30)
                            .padding(.trailing, 5)
                        
                        VStack {
                            Image(systemName: "quote.opening")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.SBTitle)
                                .frame(width: 15)
                                .padding(.bottom, 70)
                        }
                        
                        Spacer()
                        
                        Text("DUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMYDUMMY")
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                            .lineLimit(4)
                            .truncationMode(.tail)
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "quote.closing")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.SBTitle)
                                .frame(width: 15)
                                .padding(.top, 70)
                                .padding(.trailing, 40)
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
        .redacted(reason: .placeholder)
    }
}

#Preview {
    DummyProfileView()
}
