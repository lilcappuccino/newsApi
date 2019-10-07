//
//  FeedViewModel.swift
//  NewsApi
//
//  Created by dewill on 29/09/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Network
import RxSwift

class FeedViewModel {
    private let category = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    public var topArticles: PublishSubject<[ArticleApi]> = PublishSubject()
    public var error: PublishSubject<Error> = PublishSubject()
    public var categorySubject: PublishSubject<[String]> = PublishSubject()
    public var isLoadingSubject : PublishSubject<Bool> = PublishSubject()
    
    private var isInternenAvaibleSubject: PublishSubject<Bool> = PublishSubject()
    
    
    
    //MARK: -> Network request
    func fetchDate(from country: String = "us"){
        isLoadingSubject.onNext(true)
        categorySubject.onNext(category)
        NetworkService.shared.getTopArticles(from: country){ [weak self] response in
            switch response {
            case let .success(date):
                self?.isLoadingSubject.onNext(false)
                self?.topArticles.onNext(date.articles)
            case let .failure(error) :
                print(error)
                self?.error.onNext(error)
            }
        }
    }
    
    func checkIsNetworkAvaible(){
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
            }
            
            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
}
