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
    @objc dynamic var created = 0
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    var cards = RealmSwift.List<Int>()

    override static func primaryKey() -> String? {
        return "username"
    }

    var asDomain: User {

        let formattedDate = Date(timeIntervalSince1970: Double(created))
        return User(username: username, password: password, created: formattedDate, cards: Array(Set(cards)))
    }

    func sync(domain: User) {

        if created != domain.created.asKey {
            // Realm throws fatalError if inserted object primary key is being changed, even if key is same
            self.created = domain.created.asKey
        }

        username = domain.username
        password = domain.password
        cards.append(objectsIn: domain.cards)
    }
}
