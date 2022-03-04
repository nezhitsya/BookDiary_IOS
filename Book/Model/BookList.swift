//
//  BookList.swift
//  Book
//
//  Created by 이다영 on 2021/12/15.
//

import Foundation

struct BookList: Codable {
    var start: Int
    var display: Int
    var items: [Books]

    init(start: Int,
         display: Int,
         items: [Books]) {
        self.start = start
        self.display = display
        self.items = items
    }
}

extension BookList {
    static let EMPTY = BookList(start: 1, display: 10, items: [])
}
