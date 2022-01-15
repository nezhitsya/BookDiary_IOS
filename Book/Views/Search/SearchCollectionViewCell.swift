//
//  SearchCollectionViewCell.swift
//  Book
//
//  Created by 이다영 on 2021/12/13.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    
    var book: Books?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setBook(_ book: Books) {
        if let b = self.book, b.title == book.title {
            return
        }
        self.book = book

        print(self.book)
        self.coverImage.image = nil
        ImageLoader.loadImage(url: book.image) { [weak self] image in
            self?.coverImage.image = image
        }
    }

}
