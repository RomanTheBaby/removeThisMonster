//
//  DBUser.swift
//  MyProject
//
//  Created by Baby on 4/10/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa
import RealmSwift

class DBUser: Object {
    @objc dynamic var id = 0
    @objc dynamic var username = ""
    @objc dynamic var password = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
