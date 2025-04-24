//
//  BookManager.swift
//  ShareBook
//
//  Created by 권형일 on 7/29/24.
//

import Foundation
import Alamofire
import Combine

class BookManager {
    private init() {}
    
    static func requestSearchBookList(searchQuery: String) -> AnyPublisher<[Book], Error> {
        let baseURL = "https://openapi.naver.com/v1/search/book.json"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": Bundle.main.infoDictionary?["NAVER_SEARCH_CLIENT_ID"] as? String ?? "",
            "X-Naver-Client-Secret": Bundle.main.infoDictionary?["NAVER_SEARCH_CLIENT_SECRET"] as? String ?? ""
        ]
        
        let parameters: Parameters = [
            "query": searchQuery,
            "display": 50
        ]
        
        return AF.request(baseURL,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate()
        .publishDecodable(type: BookList.self)
        .value()
        .map { $0.items }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
}
