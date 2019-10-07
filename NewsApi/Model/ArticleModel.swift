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
    @objc dynamic var source: SourceModel? = nil
    @objc dynamic var image: ImageModel? = nil
    @objc dynamic var author : String? = nil
    @objc dynamic var content: String? = nil
    @objc dynamic var articleDescription: String? = nil
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var publishedAt : String = ""
    
    override static func primaryKey() -> String? {
        return "url"
    }
}

class SourceModel: Object {
    @objc dynamic var id: String? = nil
    @objc dynamic var name: String? = nil
}

class ImageModel: Object {
    @objc dynamic var imageUrl: String? = nil
    @objc dynamic var height: Float = 0.0
    @objc dynamic var width: Float = 0.0
}
