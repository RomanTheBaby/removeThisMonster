//
//  NSViewController+Extensions.swift
//  MyProject
//
//  Created by Baby on 4/12/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

extension NSViewController {

    func showAlert(for message: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.addButton(withTitle: "Зрозуміло!")
        alert.runModal()
    }

    func showAlert(for error: Error) {
        showAlert(for: error.localizedDescription)
    }
}
