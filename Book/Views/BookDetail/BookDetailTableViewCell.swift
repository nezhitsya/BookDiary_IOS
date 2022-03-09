//
//  BookDetailTableViewCell.swift
//  Book
//
//  Created by 이다영 on 2022/03/03.
//

import UIKit

class BookDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setComments(_ comments: NSDictionary) {
        self.commentLabel.text = comments["comment"] as? String
        DateConverter.loadDate(date: comments["time"] as! Int) { time in
            self.timeLabel.text = time
        }
    }
    
}
