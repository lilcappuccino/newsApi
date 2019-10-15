//
//  ArticleModel.swift
//  NewsApi
//
//  Created by dewill on 06/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation
import RealmSwift



///Object  it is mean that this struct from db

class ArticleObject: Object {
    @objc dynamic var source: SourceObject? = nil
    @objc dynamic var image: ImageObject? = nil
    @objc dynamic var author : String? = nil
    @objc dynamic var content: String? = nil
    @objc dynamic var articleDescription: String? = nil
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var addedAt: Int64 = 0
    
    override static func primaryKey() -> String? {
        return "url"
    }
}

class SourceObject: Object {
    @objc dynamic var id: String? = nil
    @objc dynamic var name: String? = nil
}

class ImageObject: Object {
    @objc dynamic var imageUrl: String? = nil
    @objc dynamic var height: Float = 0.0
    @objc dynamic var width: Float = 0.0
}
