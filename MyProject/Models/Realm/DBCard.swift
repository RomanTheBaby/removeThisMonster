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
    @objc dynamic var created = 0
    @objc dynamic var desc = ""
    @objc dynamic var title = ""
    @objc dynamic var projectID = 0
    @objc dynamic var priority = 0
    @objc dynamic var status = CardStatus.toDo.rawValue

    override static func primaryKey() -> String? {
        return "created"
    }

    var asDomain: Card {
        let cardStatus = CardStatus(rawValue: status) ?? .toDo
        let formattedDate = Date(timeIntervalSince1970: Double(created))

        let card = Card(title: title, status: cardStatus,
                        created: formattedDate, priority: priority,
                        projectId: projectID, description: desc)
        return card
    }

    func sync(domain: Card) {

        if created != domain.created.asKey {
            // Realm throws fatalError if inserted object primary key is being changed, even if key is same
            created = domain.created.asKey
        }

        desc = domain.description
        title = domain.title
        priority = domain.priority
        projectID = domain.projectId
        status = domain.status.rawValue
    }
}
