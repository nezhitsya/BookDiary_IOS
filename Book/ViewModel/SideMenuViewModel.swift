//
//  SideMenuViewModel.swift
//  Book
//
//  Created by 이다영 on 2022/02/20.
//

import Foundation
import Firebase

class SideMenuViewModel: NSObject {
    
    let userUid = Auth.auth().currentUser?.uid
    var users = Users.EMPTY
    var ref = Database.database().reference().child("Users")
    
    func getProfile(completion: @escaping (Users) -> ()) {
        self.ref.child(userUid!).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            let value = snapshot.value as? NSDictionary
            self.users = Users(dictionary: value!)
            completion(self.users)
        }
    }
    
    func editNickname(nickname: String) {
        self.ref.child(userUid!).child("nickname").setValue(nickname)
    }
    
    func editProfileImage() {
        
    }
    
}
