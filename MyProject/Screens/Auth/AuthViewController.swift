//
//  AuthViewController.swift
//  MyProject
//
//  Created by Baby on 4/4/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class AuthViewController: NSViewController {

    @IBOutlet weak private var usernameTextField: NSTextField!
    @IBOutlet weak private var passwordTextField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(red: 18/255, green: 122/255, blue: 189/255, alpha: 1.0).cgColor
//        15/104/161
//        96/177/77
    }

    @IBAction func textFieldAction(_ sender: NSTextField) {
        sender.resignFirstResponder()

        if sender == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
    }
}

extension AuthViewController: NSTextFieldDelegate {
}
