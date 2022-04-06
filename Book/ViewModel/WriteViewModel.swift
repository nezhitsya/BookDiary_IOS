//
//  WriteViewModel.swift
//  Book
//
//  Created by 이다영 on 2022/03/25.
//

import Foundation
import Firebase

class WriteViewModel: NSObject {
    
    let userUid = Auth.auth().currentUser?.uid
    var title: String = ""
    var ref = Database.database().reference().child("Diary")
    
    func write(image: String, desc: String, year: Int, month: Int, day: Int, score: Int) {
        let diaryid: String = ref.childByAutoId().key!
        ref.child(userUid!).child(diaryid).child("title").setValue(title)
        ref.child(userUid!).child(diaryid).child("image").setValue(image)
        ref.child(userUid!).child(diaryid).child("desc").setValue(desc)
        ref.child(userUid!).child(diaryid).child("year").setValue(year)
        ref.child(userUid!).child(diaryid).child("month").setValue(month)
        ref.child(userUid!).child(diaryid).child("day").setValue(day)
        ref.child(userUid!).child(diaryid).child("score").setValue(score)
    }
    
}
