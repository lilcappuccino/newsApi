//
//  FeedCategoryVCell.swift
//  NewsApi
//
//  Created by dewill on 02/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

class FeedCategoryVCell: UICollectionViewCell {
    
   public static let reuseIdentifier = "FeedCategoryVCell"

    @IBOutlet weak var categoryLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("FeedCategoryVCell - added")
    }

}
