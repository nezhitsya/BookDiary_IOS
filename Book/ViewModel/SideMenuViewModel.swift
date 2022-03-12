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
    
    func getProfile(completion: @escaping (NSDictionary) -> ()) {
        self.ref.child(userUid!).observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            let value = snapshot.value as? NSDictionary
            completion(value!)
        }
    }
    
    func editNickname(nickname: String) {
        self.ref.child(userUid!).child("nickname").setValue(nickname)
    }
    
    func editProfileImage(data: Data) {
        let imageStorage = Storage.storage().reference().child("profile/\(userUid!)/profileImage")
        imageStorage.putData(data, metadata: nil) { metadata, error in
            if (error == nil) {
                imageStorage.downloadURL { (url, error) in
                    if (error == nil) {
                        self.ref.child(self.userUid!).child("profileImage").setValue(url!.absoluteString)
                    }
                }
            }
        }
    }
    
}
