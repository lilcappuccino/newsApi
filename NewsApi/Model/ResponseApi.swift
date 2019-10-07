//
//  ApiResponse.swift
//  NewsApi
//
//  Created by dewill on 29/09/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation

enum Response {
    case success (date: ResponseApi)
    case failure (error: Error)
}

struct ResponseApi: Codable {
    let status: String
    let totalResults: Int
    let articles : [ArticleApi]
}

struct ArticleApi: Codable {
    let source: SourceApi?
    let author, content, description, urlToImage: String?
    let title, url , publishedAt : String
    
}

struct SourceApi: Codable {
    let id, name: String?
}
