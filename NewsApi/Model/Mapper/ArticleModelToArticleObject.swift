//
//  ArticleModelToArticleObject.swift
//  NewsApi
//
//  Created by dewill on 16.10.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation

class ArticleModelToArticleObject {
    
    static func map(from: ArticleModel) -> ArticleObject{
        let articleObject = ArticleObject()
        articleObject.addedAt = from.addedAt
        articleObject.articleDescription = from.articleDescription
        articleObject.author = from.author
        articleObject.content = from.content
        articleObject.publishedAt = from.publishedAt
        articleObject.title = from.title
        articleObject.url = from.url
        // source object
        let sourceObject = SourceObject()
        sourceObject.id = from.source?.id
        sourceObject.name = from.source?.name
        articleObject.source = sourceObject
        
        // image Object
        let imageObject = ImageObject()
        imageObject.height = from.image?.height ?? 0
        imageObject.width = from.image?.width ?? 0
        imageObject.imageUrl = from.image?.imageUrl
        articleObject.image = imageObject
        return articleObject
    }
    
    static func reverse(from: ArticleObject) -> ArticleModel{
        let sourceObject = from.source
        let sourceModel = SourceModel(id: sourceObject?.id, name: sourceObject?.name)
        // image
        let imageObject = from.image
        let imageModel = ImageModel(imageUrl: imageObject?.imageUrl, height: imageObject?.height ?? 0  , width: imageObject?.width ?? 0)
        
        return ArticleModel(source: sourceModel, image: imageModel, author: from.author, content: from.content, articleDescription: from.description, title: from.title, url: from.url, publishedAt: from.publishedAt, addedAt: from.addedAt)
    }
}
