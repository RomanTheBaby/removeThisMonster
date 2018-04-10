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
