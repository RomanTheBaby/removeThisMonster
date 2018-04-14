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
        if created != domain.created.asKey {
            // Realm throws fatalError if inserted object primary key is being changed, even if key is same
            self.created = domain.created.asKey
        }

        name = domain.name
    }
}

extension Date {
    var asKey: Int {
        return Int(self.timeIntervalSince1970)
    }
}
