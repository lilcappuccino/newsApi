//
//  ViewController.swift
//  NewsApi
//
//  Created by dewill on 26/09/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
               viewControllers = [
        generateNavigationController(rootViewController: FeedVC(), title: "Feed", image: #imageLiteral(resourceName: "ic_feed")),
    generateNavigationController(rootViewController: FavouriteVC(), title: "Favourite", image: #imageLiteral(resourceName: "ic_favourite")),
            generateNavigationController(rootViewController: FeedVC(), title: "Setting", image: #imageLiteral(resourceName: "ic_favourite"))
        
              ]
    }



    private func generateNavigationController(rootViewController : UIViewController, title: String, image: UIImage) -> UINavigationController {
        let nc = UINavigationController(rootViewController: rootViewController)
        nc.tabBarItem.title = title
        nc.tabBarItem.image = image
        return nc
    }
    
    
}

