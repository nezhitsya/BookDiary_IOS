//
//  PersistencyManager.swift
//  Book
//
//  Created by 이다영 on 2021/12/10.
//

import UIKit

final class PersistencyManager: NSObject {
    
    private let clientID: String = "F7osXKqVTEE6Bq_djoBM"
    private let clientKey: String = "zvhQ_5Jt0C"
    
    func requestAPI(queryValue: String, completed: @escaping (BookList) -> Void) {
        let query: String = "https://openapi.naver.com/v1/search/book.json?query=\(queryValue)"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
        
        var requestURL = URLRequest(url: queryURL)
        requestURL.addValue("/application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        requestURL.addValue(clientKey, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let bookData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                completed(self.parseBookList(jsonObject: bookData))
            } catch {
                return
            }
        }
        
        task.resume()
    }
    
    func requestNextAPI(queryValue: String, start: Int, completed: @escaping (BookList) -> Void) {
        let query: String = "https://openapi.naver.com/v1/search/book.json?query=\(queryValue)&start=\(start)"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
        
        var requestURL = URLRequest(url: queryURL)
        requestURL.addValue("/application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        requestURL.addValue(clientKey, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let bookData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                completed(self.parseBookList(jsonObject: bookData))
            } catch {
                return
            }
        }
        
        task.resume()
    }
    
    private func JSONObject(_ json: String) -> [String: Any] {
        let data = json.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        return jsonObject
    }
    
    private func parseBookList(jsonObject: [String: Any]) -> BookList {
        return BookList(start: jsonObject["start"] as! Int,
                        display: jsonObject["display"] as! Int,
                        items: (jsonObject["items"] as! [[String: Any]]).map(parseBook))
    }

    private func parseBook(jsonObject: [String: Any]) -> Books {
        return Books(title: jsonObject["title"] as! String,
                     link: jsonObject["link"] as! String,
                     author: jsonObject["author"] as! String,
                     image: jsonObject["image"] as! String,
                     price: jsonObject["price"] as! String,
                     publisher: jsonObject["publisher"] as! String,
                     pubdate: jsonObject["pubdate"] as! String,
                     isbn: jsonObject["isbn"] as! String,
                     description: jsonObject["description"] as! String)
    }
    
}
