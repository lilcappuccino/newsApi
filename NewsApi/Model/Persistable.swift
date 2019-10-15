//
//  Persistable.swift
//  NewsApi
//
//  Created by dewill on 13.10.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import Foundation
import RealmSwift


public protocol Persistable {
    associatedtype ManagedObject: Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
