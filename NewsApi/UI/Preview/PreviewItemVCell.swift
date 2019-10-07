//
//  PreviewItemVCell.swift
//  NewsApi
//
//  Created by dewill on 03/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import SDWebImage
import UIKit

class PreviewItemVCell: UICollectionViewCell {
    public static let identifier = "PreviewItemVCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resourceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    private func setupUI(){
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    
    var article : ArticleApi?{
        didSet{
            guard let currentArticle  = article else {return}
            if let urlString = currentArticle.urlToImage, let url = URL(string: urlString) {
                image.sd_setImage(
                     with: url,
                     placeholderImage: #imageLiteral(resourceName: "placeholder"),
                     options: SDWebImageOptions(rawValue: 0))
            }
            titleLabel.text = currentArticle.title
            resourceLabel.text = currentArticle.author
        }
    }
}
