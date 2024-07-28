//
//  Book.swift
//  ShareBook
//
//  Created by 권형일 on 7/27/24.
//

import Foundation

struct Book: Codable, Hashable {
    let title: String
    let image: String
    let author: String
    let publisher: String
    var pubdate: String
    let description: String
}

extension Book {
    static var DUMMY_BOOK: Book = Book(title: "OKGOSU의 액션스크립트 정석", image: "https://shopping-phinf.pstatic.net/main_3247268/32472687475.20221019151209.jpg", author: "옥상훈", publisher: "에이콘출판", pubdate:  "2010.04.19", description: "액션스크립트의 고수가 되자!\n\n「에이콘 웹 프로페셔널」 제24권 『OKGOSU의 액션스크립트 정석』. 'OKGOSU'라는 닉네임으로 13년간 자바개발자로 활동하면서 한국자바개발자협의회의 회장을 역임하기도 한 저자가, 액션스크립트에 관한 모든 것을 설명하고 있다. 2D 그래픽과 3D 그래픽, 애니메이션 프로그래밍과 게임 프로그래밍 등 액션스크립트 API가 제공하는 핵심적 기능을 배워나가도록 구성했다. 디자인과 개발 관점에서 풍부한 사용자 경험을 안겨주는 리치 인터넷 애플리케이션을 효율적으로 만드는 기술인 프래시/플렉스에 대해서도 다룬다. 플래시와 플렉스 컴포넌트를 만드는 베이스가 되는 스프라이트 클래스를 활용한 예제로 실어 적용이 쉽다.")
}
