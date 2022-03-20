//
//  DateConverter.swift
//  Book
//
//  Created by 이다영 on 2022/03/05.
//

import Foundation

class DateConverter {
    
    static func loadDate(date: Int, completed: @escaping (String?) -> Void) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        
        let dateInterval = Date(timeIntervalSince1970: TimeInterval(date / 1000))
        let convertDate = dateFormatter.string(from: dateInterval)
        
        return completed(convertDate)
    }
    
}
