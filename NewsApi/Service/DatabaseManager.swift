//
//  DatabaseManager.swift
//  NewsApi
//
//  Created by dewill on 06/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation
import RealmSwift


class DatabaseManager {
    
    static let  shared = DatabaseManager()
    private init(){}
    
    let realm = try! Realm()
    
    func writeToDatabase(apiArticle: ArticleApi, imageHeight: Float, imageWidth: Float) {
       
        
        let source = saveSource(sourceApi: apiArticle.source)
        let image = saveImage(imageUrl: apiArticle.urlToImage, imageHeight: imageHeight, imageWidth: imageHeight)
        let article = saveArticle(apiArticle: apiArticle, sourceModel: source, imageModel: image)
        
        try! realm.write {
//            if let realmSource = source { realm.add(realmSource) }
//            if let realmImage = image { realm.add(realmImage) }
            realm.add(article)
        }
    }
    
    func saveArticle(apiArticle: ArticleApi, sourceModel: SourceModel? = nil, imageModel: ImageModel? = nil) -> ArticleModel {
        let article = ArticleModel()
        article.articleDescription = apiArticle.description
        article.author = apiArticle.author
        article.content = apiArticle.content
        article.publishedAt = apiArticle.publishedAt
        article.title = apiArticle.title
        article.url = apiArticle.url
        
        article.image = imageModel
        article.source = sourceModel
        
        return article
    }
    
    func saveImage(imageUrl: String?, imageHeight: Float, imageWidth: Float) -> ImageModel? {
        guard imageUrl != nil else {return nil}
        let image = ImageModel()
        image.imageUrl = imageUrl
        image.height = imageHeight
        image.width = imageWidth
        return image
    }
    
    func saveSource(sourceApi: SourceApi?) -> SourceModel? {
        guard sourceApi != nil else { return nil }
        let sourceModel = SourceModel()
        sourceModel.id = sourceApi?.id
        sourceModel.name = sourceApi?.name
        return sourceModel
        
    }
    //Use url to private key
    func isArticleSaved(url: String ) -> Bool {
        let article = realm.objects(ArticleModel.self).filter("url == %@", url)
        return !article.isEmpty
    }
    
    func deleteArticleFromFavourite(by url: String) {
        let article = realm.objects(ArticleModel.self).filter("url == %@", url)
        try! realm.write {
            realm.delete(article)
        }
    }

    
}
