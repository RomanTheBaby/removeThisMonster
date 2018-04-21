//
//  Project.swift
//  MyProject
//
//  Created by Baby on 4/14/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

struct Project {
    var created: Date
    var name: String
    var color: NSColor
}

extension Project {
    init(date: Date = Date(), projName: String) {
        created = date
        name = projName
        color = NSColor.randomProjectColor()
    }
}
