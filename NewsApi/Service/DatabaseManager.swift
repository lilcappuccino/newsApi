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
    
    private let realm = try! Realm()
    
    func  writeToDatabase( _ article: ArticleModel){
        try! realm.write {
            realm.add(ArticleModelToArticleObject.map(from: article))
        }
    }
    
    //Use url to private key
    func isArticleSaved(url: String ) -> Bool {
        let article = realm.objects(ArticleObject.self).filter("url == %@", url)
        return !article.isEmpty
    }
    
    func deleteArticleFromFavourite(by url: String) {
        let article = realm.objects(ArticleObject.self).filter("url == %@", url)
        try! realm.write {
            realm.delete(article, cascading: true)
        }
    }
    
    
    func getAllArticle() -> Results<ArticleObject> {
        return realm.objects(ArticleObject.self)
        
    }
    
    func removeAllDb(){
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
