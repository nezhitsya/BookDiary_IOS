//
//  DetailViewModel.swift
//  Book
//
//  Created by 이다영 on 2022/01/06.
//

import Foundation

class DetailViewModel: NSObject {
    @IBOutlet var manager: PersistencyManager!
    
    private var books = Books.EMPTY
    
    var bookDetail: Books?
    
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var bookUpdated: (Books) -> Void = { _ in }
    
    func detail() {
        loadingStarted()
        self.books = bookDetail ?? Books.EMPTY
        self.bookUpdated(books)
        self.loadingEnded()
    }
}
