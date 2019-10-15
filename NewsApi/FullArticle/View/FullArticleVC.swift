//
//  FullArticleViewController.swift
//  NewsApi
//
//  Created by dewill on 04/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit
import RealmSwift

class FullArticleVC: UIViewController {
    
    @IBOutlet weak var favouriteButtonView: UIButton!
    
    @IBOutlet weak var favouriteView: UIView!
    @IBOutlet weak var browserView: UIView!
    
    @IBOutlet weak var contentTextView: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    private var viewModel = FullArticleViewModel()
    
    var article : ArticleModel?
    var image: UIImage?
    
    
    //MARK: -> Click
    @IBAction func saveArticleClicked(_ sender: UIButton) {
        if sender.isSelected {
            deleteArticle()
        } else {
            saveArticle()
        }
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func openUrlClicked(_ sender: Any) {
        if let urlString = article?.url , let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    
    
    //MARK: -> Lifecyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupUI()
    }
    
    
    
    //MARK: -> UI
    
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
    
    // MARK: -> UI for action circle button
    private func setupUIButton(to view: UIView){
        view.layer.cornerRadius = 16
    }
    
    // MARK: -> configDate
    private func configDate(publishedAt date: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date!)
        dateLabel.text = dateString
    }
    
    
    
    //MARK: -> ViewModel method
    private func saveArticle(){
        guard var savedArticle = article  else { return }
        savedArticle.image?.height = Float( image?.size.height ?? 0 )
        savedArticle.image?.width = Float( image?.size.width ?? 0)
        savedArticle.addedAt =  Date().currentTimeMillis()
        viewModel.saveArticleToDb(article: savedArticle)
        
    }
    
    private func deleteArticle(){
        guard let deletedArticle = article else { return }
        viewModel.removeArticleFromDb(by: deletedArticle.url)
    }
}
