//
//  SearchViewModel.swift
//  Book
//
//  Created by 이다영 on 2021/12/15.
//

import Foundation

class SearchViewModel: NSObject {
    
    @IBOutlet var manager: PersistencyManager!
    
    private var bookList: BookList = BookList.EMPTY
    private var loading = false
    
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var bookListUpdated: () -> Void = { }
    
    func bookCount() -> Int {
        return bookList.items.count
    }
    
    func book(at index: Int) -> Books {
        return bookList.items[index]
    }
    
    func list(s: String) {
        loading = true
        loadingStarted()
        
        manager.requestAPI(queryValue: s) {
            self.bookList = $0
            self.bookListUpdated()
            self.loadingEnded()
            self.loading = false
        }
    }
    
    func next(s: String, start: Int) {
        if loading { return }
        loading = true
        loadingStarted()
        
        manager.requestNextAPI(queryValue: s, start: start) {
            var bookList = $0
            bookList.items.insert(contentsOf: self.bookList.items, at: 0)
            self.bookList = bookList
            self.bookListUpdated()
            self.loadingEnded()
            self.loading = false
        }
    }
    
}
