//
//  FavouriteViewModel.swift
//  NewsApi
//
//  Created by dewill on 07/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import RxSwift

class FavouriteViewModel {
    let articlesSubject: PublishSubject<[ArticleModel]> = PublishSubject()
    
    
    
    func fetchDateFromDb(){
        let articleList = DatabaseManager.shared.getAllArticle().toArray().map({ArticleModel(managedObject: $0)})
        articlesSubject.onNext(articleList)
    }
}
