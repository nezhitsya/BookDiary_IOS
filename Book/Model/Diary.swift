//
//  Diary.swift
//  Book
//
//  Created by 이다영 on 2022/04/06.
//

import Foundation

struct Diary: Codable {
    let image: String
    let year: Int
    let month: Int
    let day: Int
    let desc: String
    
    init(image: String,
         year: Int,
         month: Int,
         day: Int,
         desc: String) {
        self.image = image
        self.year = year
        self.month = month
        self.day = day
        self.desc = desc
    }
}

extension Diary {
    static let EMPTY = Diary(image: "", year: 2022, month: 4, day: 20, desc: "")
}
