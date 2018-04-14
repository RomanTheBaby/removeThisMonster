//
//  DBProject.swift
//  MyProject
//
//  Created by Baby on 4/14/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa
import RealmSwift

class DBProject: Object {
    @objc dynamic var created = 0
    @objc dynamic var name = ""

    override static func primaryKey() -> String? {
        return "created"
    }

    var asDomain: Project {
        let formattedDate = Date(timeIntervalSince1970: Double(created))
        return Project(created: formattedDate, name: name)
    }

    func sync(domain: Project) {
        if created != Int(domain.created.timeIntervalSince1970) {
            // Realm throws fatalError if inserted object primary key is being changed, even if key is same
            self.created = Int(domain.created.timeIntervalSince1970)
        }

        name = domain.name
    }
}
