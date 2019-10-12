//
//  DateExtension.swift
//  NewsApi
//
//  Created by dewill on 12.10.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
