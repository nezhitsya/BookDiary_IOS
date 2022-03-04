//
//  Comments.swift
//  Book
//
//  Created by 이다영 on 2022/03/05.
//

import Foundation

struct Comments: Codable {
    var time: Int
    var comment: String

    init(time: Int,
         comment: String) {
        self.time = time
        self.comment = comment
    }
}

extension Comments {
    static let EMPTY = Comments(time: 0, comment: "")
}
