//
//  CardStatus.swift
//  MyProject
//
//  Created by Baby on 4/10/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

enum CardStatus: Int, Equatable {
    case toDo
    case inProgress
    case done
}

extension CardStatus {

    static let All: [CardStatus] = [.toDo, .inProgress, .done]

    var localizedDescription: String {
        switch self {
        case .toDo:
            return "До виконання"
        case .inProgress:
            return "В процесі"
        case .done:
            return "Завершені"
        }
    }
}
