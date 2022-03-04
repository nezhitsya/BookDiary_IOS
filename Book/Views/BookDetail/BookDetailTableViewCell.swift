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
    
    var comments: Comments?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setComments(_ comments: Comments) {
        if let c = self.comments, c.comment == comments.comment {
            return
        }
        self.comments = comments
        self.commentLabel.text = comments.comment
        
        DateConverter.loadDate(date: comments.time) { time in
            self.timeLabel.text = time
        }
    }
    
}
