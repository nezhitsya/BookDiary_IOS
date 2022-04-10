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
    
    var diary: [NSDictionary]?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func dateText(text: String) {
        dateLabel.text = text
    }
    
    func setImage(diary: [NSDictionary], year: Int, month: Int, day: String) {
        if !diary.isEmpty {
            for i in 0..<diary.count {
                if diary[i]["year"] as! Int == year && diary[i]["month"] as! Int == month && diary[i]["day"] as! Int == Int(day) {
                    ImageLoader.loadImage(url: diary[i]["image"] as! String) { [weak self] image in
                        self?.dateImage.image = image
                    }
                } else {
                    self.dateImage.image = nil
                }
            }
        }
    }

}
