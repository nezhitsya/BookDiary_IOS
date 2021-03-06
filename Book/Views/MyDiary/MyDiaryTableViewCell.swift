//
//  MyDiaryTableViewCell.swift
//  Book
//
//  Created by 이다영 on 2022/04/09.
//

import UIKit

class MyDiaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setDiary(_ diaries: NSDictionary) {
        self.titleLabel.text = diaries["title"] as? String
        self.descLabel.text = diaries["desc"] as? String
        self.dateLabel.text = "\(String(describing: diaries["year"]!))년 \(String(describing: diaries["month"]!))월 \(String(describing: diaries["day"]!))일"
        
        ImageLoader.loadImage(url: diaries["image"] as! String) { [weak self] image in
            self?.coverImage.image = image
        }
    }
    
}
