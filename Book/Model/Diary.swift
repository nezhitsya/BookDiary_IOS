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
    
    init(image: String,
         year: Int,
         month: Int,
         day: Int) {
        self.image = image
        self.year = year
        self.month = month
        self.day = day
    }
}

extension Diary {
    static let EMPTY = Diary(image: "", year: 0, month: 0, day: 0)
}
