//
//  ArticleModel.swift
//  NewsApi
//
//  Created by dewill on 13.10.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation

struct ArticleModel {
    
    let source: SourceModel?
    let image: ImageModel?
    let author : String?
    let content: String?
    let articleDescription: String?
    let title: String
    let url: String
    let publishedAt: String
    let addedAt: Int64
    
    
    
}

struct SourceModel {
    let id: String?
    let name: String?
}

struct ImageModel {
    let imageUrl: String?
    let height: Float 
    let width: Float
}



//MARK: -> Model to Object lvl
extension ArticleModel: Persistable {
    typealias ManagedObject = ArticleObject
    
    public init(managedObject: ArticleObject) {
        // source
        let sourceManagedObject = managedObject.source
        source = SourceModel(id: sourceManagedObject?.id, name: sourceManagedObject?.name)
        // image
        let imageObject = managedObject.image
        image = ImageModel(imageUrl: imageObject?.imageUrl, height: imageObject?.height ?? 0  , width: imageObject?.width ?? 0)
        
        author = managedObject.author
        content = managedObject.content
        articleDescription = managedObject.articleDescription
        title = managedObject.title
        url = managedObject.url
        publishedAt = managedObject.publishedAt
        addedAt  = managedObject.addedAt
        
    }
    public func managedObject() -> ArticleObject {
        let articleObject = ArticleObject()
        articleObject.addedAt = self.addedAt
        articleObject.articleDescription = self.articleDescription
        articleObject.author = self.author
        articleObject.content = self.content
        articleObject.publishedAt = self.publishedAt
        articleObject.title = self.title
        articleObject.url = self.url
        // source object
        let sourceObject = SourceObject()
        sourceObject.id = self.source?.id
        sourceObject.name = self.source?.name
        articleObject.source = sourceObject
        
        // image Object
        let imageObject = ImageObject()
        imageObject.height = self.image?.height ?? 0
        imageObject.width = self.image?.width ?? 0
        imageObject.imageUrl = self.image?.imageUrl
        articleObject.image = imageObject
        return articleObject
    }
}

// MARK: -> Model to Api lvl
//
//extension ArticleModel: Persistable {
//    typealias ManagedObject = ArticleApi
//
//    public init(managedObject: ArticleApi) {
//        // source
//        let sourceManagedObject = managedObject.source
//        source = SourceModel(id: sourceManagedObject?.id, name: sourceManagedObject?.name)
//        // image
//        let imageObject = managedObject.image
//        image = ImageModel(imageUrl: imageObject?.imageUrl, height: imageObject?.height ?? 0  , width: imageObject?.width ?? 0)
//
//        author = managedObject.author
//        content = managedObject.content
//        articleDescription = managedObject.articleDescription
//        title = managedObject.title
//        url = managedObject.url
//        publishedAt = managedObject.publishedAt
//        addedAt  = managedObject.addedAt
//
//    }
//    public func managedObject() -> ArticleObject {
//        let articleObject = ArticleObject()
//        articleObject.addedAt = self.addedAt
//        articleObject.articleDescription = self.articleDescription
//        articleObject.author = self.author
//        articleObject.content = self.content
//        articleObject.publishedAt = self.publishedAt
//        articleObject.title = self.title
//        articleObject.url = self.url
//        // source object
//        let sourceObject = SourceObject()
//        sourceObject.id = self.source?.id
//        sourceObject.name = self.source?.name
//        articleObject.source = sourceObject
//
//        // image Object
//        let imageObject = ImageObject()
//        imageObject.height = self.image?.height ?? 0
//        imageObject.width = self.image?.width ?? 0
//        imageObject.imageUrl = self.image?.imageUrl
//        articleObject.image = imageObject
//        return articleObject
//    }
//}

