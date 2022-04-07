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
    
    var diary: Diary?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func dateText(text: String) {
        dateLabel.text = text
    }
    
    func setImage(_ diary: Diary) {
        ImageLoader.loadImage(url: diary.image) { [weak self] image in
            self?.dateImage.image = image
        }
    }

}
