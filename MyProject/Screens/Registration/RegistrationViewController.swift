//
//  RegistrationViewController.swift
//  MyProject
//
//  Created by Baby on 4/11/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class RegistrationViewController: NSViewController {

    @IBOutlet weak private var usernameTextField: NSTextField!
    @IBOutlet weak private var passwordTextField: NSTextField!
    @IBOutlet weak private var signInButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearence()
    }

    // MARK: - Private Methods

    private func configureAppearence() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blue.cgColor

        usernameTextField.setCornetRadius()
        passwordTextField.setCornetRadius()

        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .center

        signInButton.isBordered = false
        signInButton.wantsLayer = true
        signInButton.layer?.backgroundColor = NSColor.lightGreen.cgColor
        signInButton.attributedTitle = NSAttributedString(string: "Зареєструватись",
                                                          attributes: [.foregroundColor: NSColor.white,
                                                                       .paragraphStyle: pstyle])
    }

    // MARK: - Action Handlers

    @IBAction func textFieldAction(_ sender: NSTextField) {
        sender.resignFirstResponder()

        if sender == usernameTextField {
            passwordTextField.becomeFirstResponder()
        }
    }

    @IBAction func actionLogin(_ sender: NSButton) {
    }
}
