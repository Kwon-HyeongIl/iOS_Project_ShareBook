//
//  Comment.swift
//  ShareBook
//
//  Created by 권형일 on 8/15/24.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: String
    
    let commentText: String
    
    let postId: String
    let postUserId: String
    
    let commentUserId: String
    var commentUser: User?
    
    var commentReplyCount: Int?
    
    let date: Date
}

extension Comment {
    static var DUMMY_COMMENT: Comment = Comment(id: UUID().uuidString, commentText: "dummy commentajdfhpaoidhfpaoiehfpoaiehfpaoisfh;asdoilfoaweiofhawoeifha;owiehfoaisehf;alsehfa;oiesfaoeisfa;eshfa;lwehfaoweihfoaiwehf;aoiewhf;oashf;oaiehf;aoiewhf;aorihfga;oerifhaoeirhfaoiewfh;aoiwefh", postId: UUID().uuidString, postUserId: UUID().uuidString, commentUserId: UUID().uuidString, commentUser: User.DUMMY_USER, commentReplyCount: 0, date: Date())
}
