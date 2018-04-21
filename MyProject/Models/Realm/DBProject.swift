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
    @objc dynamic var colorData: Data?

    override static func primaryKey() -> String? {
        return "created"
    }

    var asDomain: Project {
        let formattedDate = Date(timeIntervalSince1970: Double(created))

        let color: NSColor

        if let data = colorData {
            color = NSKeyedUnarchiver.unarchiveObject(with: data) as! NSColor
        } else {
            color = .purple
        }

        return Project(created: formattedDate, name: name, color: color)
    }

    func sync(domain: Project) {
        if created != domain.created.asKey {
            // Realm throws fatalError if inserted object primary key is being changed, even if key is same
            self.created = domain.created.asKey
        }

        name = domain.name
        colorData = NSKeyedArchiver.archivedData(withRootObject: domain.color)
    }
}

extension Date {
    var asKey: Int {
        return Int(self.timeIntervalSince1970)
    }
}
