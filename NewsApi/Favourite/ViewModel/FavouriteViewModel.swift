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
        let articleList = DatabaseManager.shared.getAllArticle().toArray().map({ArticleModelToArticleObject.reverse(from: $0)})
        let sortedList = articleList.sorted(by: { $0.addedAt > $1.addedAt })
        articlesSubject.onNext(sortedList)
    }
}
