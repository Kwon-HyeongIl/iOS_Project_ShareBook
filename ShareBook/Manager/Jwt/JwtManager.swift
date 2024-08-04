//
//  JwtManager.swift
//  ShareBook
//
//  Created by 권형일 on 7/30/24.
//

import Foundation

class JwtManager {
    static func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let length = Double(base64.lengthOfBytes(using: .utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64.append(padding)
        }
        
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    static func decodeJWTPart(_ value: String) -> [String: Any]? {
        guard let bodyData = base64UrlDecode(value),
              let json = try? JSONSerialization.jsonObject(with: bodyData, options: []),
              let payload = json as? [String: Any] else {
            return nil
        }
        
        return payload
    }

    static func extractEmailFromJwt(from jwtToken: String) -> String? {
        let segments = jwtToken.split(separator: ".")
        guard segments.count == 3 else { return nil }
        
        if let payload = decodeJWTPart(String(segments[1])),
           let email = payload["email"] as? String {
            return email
            
        } else {
            return nil
        }
    }
}
