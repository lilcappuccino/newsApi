//
//  ArticleModel.swift
//  NewsApi
//
//  Created by dewill on 06/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation
import RealmSwift



///Model it is mean that this struct from db

class ArticleModel: Object {
    @objc var source: SourceModel? = nil
    @objc var image: ImageModel? = nil
    @objc var author : String? = nil
    @objc var content: String? = nil
    @objc var articleDescription: String? = nil
    @objc var title: String = ""
    @objc var url: String = ""
    @objc var publishedAt : String = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}

class SourceModel: Object {
    @objc var id: String? = nil
    @objc var name: String? = nil
}

class ImageModel: Object {
    @objc var imageUrl: String? = nil
    @objc var height: Float = 0.0
    @objc var width: Float = 0.0
}
