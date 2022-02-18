//
//  RoundImage.swift
//  Book
//
//  Created by 이다영 on 2022/02/17.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
    }
    
}
