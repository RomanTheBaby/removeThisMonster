//
//  Card.swift
//  MyProject
//
//  Created by Baby on 4/10/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

struct Card: Equatable {
    var title: String
    var status: CardStatus
    var created: Int
    var priority: Int
    var projectId: Int
    var description: String
}
