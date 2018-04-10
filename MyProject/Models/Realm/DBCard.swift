//
//  DBCard.swift
//  MyProject
//
//  Created by Baby on 4/10/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa
import RealmSwift

class DBCard: Object {
    @objc dynamic var id = 0
    @objc dynamic var desc = ""
    @objc dynamic var title = ""
    @objc dynamic var status = CardStatus.toDo.rawValue
}
