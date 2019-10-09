//
//  SettingViewModel.swift
//  NewsApi
//
//  Created by dewill on 09/10/2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation

class SettingViewModel {
    
    func removeAllFavourite(){
        DatabaseManager.shared.removeAllDb()
    }
}
