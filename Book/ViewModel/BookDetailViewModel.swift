//
//  DetailViewModel.swift
//  Book
//
//  Created by 이다영 on 2022/01/06.
//

import Foundation
import Firebase

class BookDetailViewModel: NSObject {
    @IBOutlet var manager: PersistencyManager!
    
    private var books = Books.EMPTY
    
    var bookDetail: Books?
    
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var bookUpdated: (Books) -> Void = { _ in }
    
    func commentCount() -> Int {
        return 10
    }
    
    func detail() {
        loadingStarted()
        self.books = bookDetail ?? Books.EMPTY
        self.bookUpdated(books)
        self.loadingEnded()
    }
    
    func writeComment(title: String, comment: String) {
        let ref = Database.database().reference().child("Comments").child(title)
        let commentid: String = ref.childByAutoId().key!
        ref.child(commentid).child("comment").setValue(comment)
        
        let time = Date()
        let timeLong = time.timeIntervalSince1970
        ref.child(commentid).child("time").setValue(Int(timeLong * 1000))
    }
}
