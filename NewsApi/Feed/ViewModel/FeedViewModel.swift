//
//  FeedViewModel.swift
//  NewsApi
//
//  Created by dewill on 29/09/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import RxSwift

class FeedViewModel {
    
    public var topArticles: PublishSubject<[ArticleModel]> = PublishSubject()
    public var error: PublishSubject<Error> = PublishSubject()
    public var isLoadingSubject : PublishSubject<Bool> = PublishSubject()
    
    //MARK: -> Network request
    func fetchDate(from country: String = "us"){
        isLoadingSubject.onNext(true)
        NetworkService.shared.getTopArticles(from: country){ [weak self] response in
            switch response {
            case let .success(date):
                self?.isLoadingSubject.onNext(false)
                let articleModel = date.articles.map({ArticleModelToApiMapper.reverse(from: $0)}).self
                self?.topArticles.onNext(articleModel)
            case let .failure(error) :
                print(error)
                self?.error.onNext(error)
            }
        }
    }
    
}
