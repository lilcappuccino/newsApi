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
    var image: ImageModel?
    let author : String?
    let content: String?
    let articleDescription: String?
    let title: String
    let url: String
    let publishedAt: String
    var addedAt: Int64
    
    
    
}

struct SourceModel {
    let id: String?
    let name: String?
}

struct ImageModel {
    let imageUrl: String?
    var height: Float
    var width: Float
}


