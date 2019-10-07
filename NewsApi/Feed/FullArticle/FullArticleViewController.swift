//
//  FullArticleViewController.swift
//  NewsApi
//
//  Created by dewill on 04/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit
import RealmSwift

class FullArticleViewController: UIViewController {
    
    @IBOutlet weak var favouriteButtonView: UIButton!
    
    @IBOutlet weak var favouriteView: UIView!
    @IBOutlet weak var browserView: UIView!
    
    @IBOutlet weak var contentTextView: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var article : ArticleApi?
    var image: UIImage?
    
    @IBAction func saveArticleClicked(_ sender: UIButton) {
        if sender.isSelected {
             deleteArticle()
        } else {
             saveArticle()
        }
        sender.isSelected = !sender.isSelected
        
    }
    
    
    private func saveArticle(){
        guard let savedArticle = article else { return }
        DatabaseManager.shared.writeToDatabase(apiArticle: savedArticle, imageHeight: Float(
            image?.size.height ?? 0), imageWidth: Float(image?.size.width ?? 0)).self
    }
    
    private func deleteArticle(){
        guard let deletedArticle = article else { return }
        DatabaseManager.shared.deleteArticleFromFavourite(by: deletedArticle.url)
    }
    
    @IBAction func openUrlClicked(_ sender: Any) {
        if let urlString = article?.url , let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print(Realm.Configuration.defaultConfiguration.fileURL!)
        setupImageView()
        setupUI()
    }
    
    
    
    
    private func setupUI(){
        guard let currentArticle = article else {return}
        favouriteButtonView.isSelected = DatabaseManager.shared.isArticleSaved(url: currentArticle.url )
        contentTextView.text = currentArticle.content
        sourceLabel.text = currentArticle.source?.name ?? currentArticle.author ?? "noname"
        setupTitle(for: currentArticle.title)
        setupUIForActionButton()
        configDate(publishedAt: currentArticle.publishedAt)
    }
    
    
    private func setupTitle(for title : String){
        titleLabel.text = title
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
    }
    
    private func setupImageView(){
        guard let articleImage = image else {return}
        let aspectRatio = articleImage.size.height / articleImage.size.width
        articleImageView.heightAnchor.constraint(equalTo: articleImageView.widthAnchor, multiplier: aspectRatio).isActive = true
        articleImageView.image = articleImage
    }
    
    private func setupUIForActionButton(){
        favouriteButtonView.setImage(UIImage(systemName: "bookmark"), for: .normal)
        favouriteButtonView.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        
        setupUIButton(to: favouriteView)
        setupUIButton(to: browserView)
    }
    
    private func configDate(publishedAt date: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date!)
        dateLabel.text = dateString
    }
    
    private func setupUIButton(to view: UIView){
        view.layer.cornerRadius = 16
    }
    
}
