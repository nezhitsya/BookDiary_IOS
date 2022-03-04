//
//  TextConverter.swift
//  Book
//
//  Created by 이다영 on 2022/01/14.
//

import Foundation

class TextConverter {
    private static var textCache = [String: NSAttributedString]()

    static func loadText(text: String, completed: @escaping (NSAttributedString?) -> Void) {
        if text.isEmpty {
            completed(nil)
            return
        }

        if let text = textCache[text] {
            DispatchQueue.main.async {
                completed(text)
            }
            return
        }

        guard let data = text.data(using: .utf8) else {
            return completed(nil)
        }
        
        do {
            return completed(try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil))
        } catch {
            return completed(nil)
        }
    }
}
