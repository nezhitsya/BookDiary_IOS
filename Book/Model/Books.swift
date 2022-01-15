//
//  Books.swift
//  Book
//
//  Created by 이다영 on 2021/12/10.
//

import Foundation

struct Books: Codable {
    let title: String
    let link: String
    let author: String
    let image: String
    let price: String
    let publisher: String
    let pubdate: String
    let isbn: String
    let description: String
    
    init(title: String,
         link: String,
         author: String,
         image: String,
         price: String,
         publisher: String,
         pubdate: String,
         isbn: String,
         description: String) {
        self.title = title
        self.link = link
        self.author = author
        self.image = image
        self.price = price
        self.publisher = publisher
        self.pubdate = pubdate
        self.isbn = isbn
        self.description = description
    }
}

extension Books {
    static let EMPTY = Books(title: "", link: "", author: "", image: "", price: "", publisher: "", pubdate: "", isbn: "", description: "")
}
