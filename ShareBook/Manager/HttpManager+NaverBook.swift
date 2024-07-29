//
//  HttpManager+NaverBook.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import Foundation
import Alamofire

extension HttpManager {
    static func requestSearchBookList(searchQuery: String, completion: @escaping ([Book]) -> Void) {
        let baseURL = "https://openapi.naver.com/v1/search/book.json"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": Bundle.main.infoDictionary?["NAVER_SEARCH_CLIENT_ID"] as? String ?? "",
            "X-Naver-Client-Secret": Bundle.main.infoDictionary?["NAVER_SEARCH_CLIENT_SECRET"] as? String ?? ""
        ]
        
        let parameters: Parameters = [
            "query": searchQuery,
            "display": 50
        ]
        
        AF.request(baseURL,
                   method: .get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: headers)
        
        .validate(statusCode: 200...500)
        
        .responseDecodable(of: BookList.self) { response in
            switch response.result {
                case .success(let data):
                    guard let statusCode = response.response?.statusCode else { return }
                
                    if statusCode == 200 {
                        DispatchQueue.main.async {
                            completion(data.items)
                        }
                    }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
