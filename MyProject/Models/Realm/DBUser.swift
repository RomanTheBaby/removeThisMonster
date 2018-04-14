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
    var cards = RealmSwift.List<DBCard>()

//    override static func primaryKey() -> String? {
//        return "created"
//    }

    override static func primaryKey() -> String? {
        return "username"
    }

    var asDomain: User {

        let userCards = Array(cards.map { $0.asDomain })

        let formattedDate = Date(timeIntervalSince1970: Double(created))
        return User(username: username, password: password, created: formattedDate, cards: userCards)
    }

    func sync(domain: User) {

        if created != domain.created.asKey {
            // Realm throws fatalError if inserted object primary key is being changed, even if key is same
            self.created = domain.created.asKey
        }

        username = domain.username
        password = domain.password

        let dbCards = domain.cards.compactMap { card -> DBCard in
            let dbCard = DBCard()
            dbCard.created = card.created.asKey
            dbCard.desc = card.description
            dbCard.title = card.title
            dbCard.status = card.status.rawValue

            return dbCard
        }

        cards.append(contentsOf: dbCards)

    }
}
