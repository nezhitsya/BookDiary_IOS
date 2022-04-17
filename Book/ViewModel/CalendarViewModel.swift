//
//  CalendarViewModel.swift
//  Book
//
//  Created by 이다영 on 2022/04/06.
//

import Foundation
import Firebase

class CalendarViewModel: NSObject {
    
    let userUid = Auth.auth().currentUser?.uid
    var ref = Database.database().reference().child("Diary")
    var diaryList: [NSDictionary] = []
    private var loading = false
    
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var diaryListUpdated: () -> Void = { }
    
    func diaryCount() -> Int {
        return diaryList.count
    }
    
    func diaries(at index: Int) -> NSDictionary {
        return diaryList[index]
    }
    
    func list() {
        diaryList.removeAll()
        loading = true
        loadingStarted()
        
        ref.child(userUid!).observeSingleEvent(of: .value) { [self] (snapshot: DataSnapshot) in
            for dataSnapshot in snapshot.children {
                self.diaryList.append((dataSnapshot as! DataSnapshot).value as! NSDictionary)
                self.diaryListUpdated()
                self.loadingEnded()
                self.loading = false
            }
        }
    }
    
    func deleteDiary(at index: Int) {
        ref.child(userUid!).child(diaryList[index]["diaryid"] as! String).removeValue()
    }
    
}
