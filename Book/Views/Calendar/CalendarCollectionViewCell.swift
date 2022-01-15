//
//  CalendarCollectionViewCell.swift
//  Book
//
//  Created by 이다영 on 2021/12/09.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func dateText(text: String) {
        dateLabel.text = text
    }

}
