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
    @objc dynamic var status = CardStatus.toDo.rawValue

    override static func primaryKey() -> String? {
        return "created"
    }

    var asDomain: Card {
        let cardStatus = CardStatus(rawValue: status) ?? .toDo
        let formattedDate = Date(timeIntervalSince1970: Double(created))

        let card = Card(title: title, status: cardStatus,
                        created: formattedDate, projectId: projectID, description: desc)
        return card
    }

    func sync(domain: Card) {

        if created != Int(domain.created.timeIntervalSince1970) {
            // Realm throws fatalError if inserted object primary key is being changed, even if key is same
            self.created = Int(domain.created.timeIntervalSince1970)
        }

        desc = domain.description
        title = domain.title
        projectID = domain.projectId
        status = domain.status.rawValue
    }
}
