//
//  LoginViewModel.swift
//  Book
//
//  Created by 이다영 on 2022/02/24.
//

import Foundation
import Firebase

class LoginViewModel: NSObject {
    
    let userUid = Auth.auth().currentUser?.uid
    var ref = Database.database().reference().child("Users")
    
    func login(completion: @escaping (Bool) -> Void) {
        Auth.auth().signInAnonymously(completion: { (user, error) in
            if (error == nil) {
                self.ref.child("Users").child((user?.user.uid)!).child("uid").observeSingleEvent(of: DataEventType.value, with: { (snapshot: DataSnapshot) in
                    if (snapshot.exists()) {
                        self.ref.child("Users").child((user?.user.uid)!).child("uid").setValue((user?.user.uid)!)
                        self.ref.child("Users").child((user?.user.uid)!).child("nickname").setValue("닉네임")
                        self.ref.child("Users").child((user?.user.uid)!).child("profileImage").setValue("https://firebasestorage.googleapis.com/v0/b/book-a32f3.appspot.com/o/profile%2Fprofile.png?alt=media&token=ff5fb4e6-14e0-4bd3-889d-7f9e0124113b")
                        completion(true)
                    } else {
                        completion(false)
                    }
                })
            }
        })
    }
    
}
