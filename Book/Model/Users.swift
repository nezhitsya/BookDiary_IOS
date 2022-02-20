//
//  Users.swift
//  Book
//
//  Created by 이다영 on 2022/02/20.
//

import Foundation
import Firebase

struct Users: Codable {
    var uid: String
    var nickname: String
    var profileImage: String
    
    init(dictionary: NSDictionary) {
        self.uid = dictionary["uid"] as? String ?? String(Auth.auth().currentUser!.uid)
        self.nickname = dictionary["nickname"] as? String ?? "닉네임"
        self.profileImage = dictionary["profileImage"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/book-a32f3.appspot.com/o/profile%2Fprofile.png?alt=media&token=ff5fb4e6-14e0-4bd3-889d-7f9e0124113b"
    }
}

extension Users {
    static let EMPTY = Users(dictionary: ["uid": Auth.auth().currentUser!.uid, "nickname": "닉네임", "profileImage": "https://firebasestorage.googleapis.com/v0/b/book-a32f3.appspot.com/o/profile%2Fprofile.png?alt=media&token=ff5fb4e6-14e0-4bd3-889d-7f9e0124113b"])
}
