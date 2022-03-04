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
    
    private var commentList: [Comments] = []
    
    private var loading = false
    
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var bookUpdated: (Books) -> Void = { _ in }
    var commentUpdated: () -> Void = {  }
    
    func detail() {
        loading = true
        loadingStarted()
        self.books = bookDetail ?? Books.EMPTY
        self.bookUpdated(books)
        self.loadingEnded()
    }
    
    func commentCount() -> Int {
        return commentList.count
    }
    
    func comments(at index: Int) -> Comments {
        return commentList[index]
    }
    
    func list(title: String) {
        loading = true
        loadingStarted()
        
        Database.database().reference().child("Comments").child(title).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            for dataSnapshot in snapshot.children {
                self.commentList = ((dataSnapshot as! DataSnapshot).value as? [Comments])!
                self.commentUpdated()
                self.loadingEnded()
                self.loading = false
            }
        }
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
