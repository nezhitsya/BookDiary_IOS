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
    var ref = Database.database().reference().child("Diary")
    
    func write(title: String, image: String, desc: String, year: Int, month: Int, day: Int) {
        let diaryid: String = ref.childByAutoId().key!
        ref.child(diaryid).child("title").setValue(title)
        ref.child(diaryid).child("image").setValue(image)
        ref.child(diaryid).child("desc").setValue(desc)
        ref.child(diaryid).child("year").setValue(year)
        ref.child(diaryid).child("month").setValue(month)
        ref.child(diaryid).child("day").setValue(day)
    }
    
}
