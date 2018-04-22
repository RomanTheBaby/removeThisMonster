//
//  User.swift
//  MyProject
//
//  Created by Baby on 4/4/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

struct User: Equatable {
    var username: String
    var password: String
    var created: Date
    var cards: [Card]
}
