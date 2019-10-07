//
//  FullArticleViewModel.swift
//  NewsApi
//
//  Created by dewill on 07/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import RxSwift

class FullArticleViewModel {
    
    func removeArticleFromDb(by url: String){
        DatabaseManager.shared.deleteArticleFromFavourite(by: url)
    }
    
    func saveArticleToDb(article: ArticleApi, imageSize: CGSize?){
        DatabaseManager.shared.writeToDatabase(apiArticle: article, imageSize: imageSize)
    }
}
