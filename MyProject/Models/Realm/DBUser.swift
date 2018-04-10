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
    @objc dynamic var cards: [DBCard]?

    override static func primaryKey() -> String? {
        return "created"
    }

    var asDomain: User {
        let userCards = cards?.compactMap { $0.asDomain } ?? []

        let formattedDate = Date(timeIntervalSince1970: Double(created))
        return User(username: username, password: password, created: formattedDate, cards: userCards)
    }

    func sync(domain: User) {

        if created != Int(domain.created.timeIntervalSince1970) {
            // Realm throws fatalError if inserted object primary key is being changed, even if key is same
            self.created = Int(domain.created.timeIntervalSince1970)
        }

        username = domain.username
        password = domain.password

        cards = domain.cards.compactMap { card -> DBCard in
            let dbCard = DBCard()
            dbCard.id = card.id
            dbCard.desc = card.description
            dbCard.title = card.title
            dbCard.status = card.status.rawValue

            return dbCard
        }
    }
}
