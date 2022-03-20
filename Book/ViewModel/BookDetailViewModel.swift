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
    
    private var bookTitle = ""
    private var books = Books.EMPTY
    var bookDetail: Books?
    
    private var commentList: [NSDictionary] = []
    
    private var loading = false
    
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var bookUpdated: (Books) -> Void = { _ in }
    var commentUpdated: () -> Void = {  }
    
    func detail() {
        loading = true
        loadingStarted()
        self.books = bookDetail ?? Books.EMPTY
        TextConverter.loadText(text: books.title) { title in
            self.bookTitle = title!.string
        }
        list()
        self.bookUpdated(books)
        self.loadingEnded()
    }
    
    func commentCount() -> Int {
        return commentList.count
    }
    
    func comments(at index: Int) -> NSDictionary {
        return commentList[index]
    }
    
    func list() {
        commentList.removeAll()
        Database.database().reference().child("Comments").child(bookTitle).observeSingleEvent(of: .value) { [self] (snapshot: DataSnapshot) in
            for dataSnapshot in snapshot.children {
                self.commentList.append((dataSnapshot as! DataSnapshot).value as! NSDictionary)
                self.commentUpdated()
            }
        }
    }
    
    func writeComment(comment: String) {
        let ref = Database.database().reference().child("Comments").child(bookTitle)
        let commentid: String = ref.childByAutoId().key!
        ref.child(commentid).child("comment").setValue(comment)
        
        let time = Date()
        let timeLong = time.timeIntervalSince1970
        ref.child(commentid).child("time").setValue(Int(timeLong * 1000))
        
        list()
    }
}
