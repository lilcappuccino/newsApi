//
//  NetworkUtils.swift
//  NewsApi
//
//  Created by dewill on 28/09/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Alamofire

class NetworkService {
    //MARK: -> Singleton
    private init(){}
    static var shared = NetworkService()
    
    private let key = "d1789ab57beb423cb9c304cca673f73c"
    private let baseUrl = "https://newsapi.org/v2/"
    
    
    //MARK: get top articles
    //TODO Refactioring completion block
    func getTopArticles(from country: String, completion: @escaping (Response) -> Void) {
        let params : [String: Any] = [
            "apiKey" : key,
            "country": country
        ]
        
        let category = "top-headlines"
        let url = baseUrl + category
        AF.request(url, method: .get, parameters: params).validate().responseJSON {
            response in
            switch response.result {
            case .success( _):
                guard let data  = response.data else {return}
                do {
                    let response = try JSONDecoder().decode(ResponseApi.self, from: data)
                    completion(.success(date: response))
                } catch {
                    print(error)
                }
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
}
