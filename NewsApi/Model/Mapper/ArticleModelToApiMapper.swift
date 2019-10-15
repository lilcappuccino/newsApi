//
//  ArticleModelToApiMapper.swift
//  NewsApi
//
//  Created by dewill on 07/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation

class ArticleModelToApiMapper {
    
    static func map(from: ArticleModel) -> ArticleApi{
        let source = SourceApi(id: from.source?.id, name: from.source?.name)
        return ArticleApi(source: source, author: from.author, content: from.content, description: from.content, urlToImage: from.image?.imageUrl, title: from.title, url: from.url, publishedAt: from.publishedAt)
    }
    
    static func reverse(from: ArticleApi) -> ArticleModel{
        let source = SourceModel(id: from.source?.id, name: from.source?.name)
        let imageModel = ImageModel(imageUrl: from.urlToImage, height: 0, width: 0)
        return ArticleModel(source: source, image: imageModel, author: from.author, content: from.content, articleDescription: from.description, title: from.title, url: from.url, publishedAt: from.publishedAt, addedAt: 0)
    }
    
}
