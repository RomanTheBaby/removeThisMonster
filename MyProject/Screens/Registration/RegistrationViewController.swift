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
    @IBOutlet weak private var errorLabel: NSTextField!

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
        signInButton.setCornetRadius()

        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .center

        signInButton.isBordered = false
        signInButton.wantsLayer = true
        signInButton.layer?.backgroundColor = NSColor.lightGreen.cgColor
        signInButton.attributedTitle = NSAttributedString(string: "Зареєструватись",
                                                          attributes: [.foregroundColor: NSColor.white,
                                                                       .paragraphStyle: pstyle])

        errorLabel.isHidden = true
        errorLabel.wantsLayer = true
        errorLabel.layer?.cornerRadius = 10
        errorLabel.layer?.backgroundColor = NSColor.red.cgColor
    }

    private func registerUser() {
        let username = usernameTextField.stringValue
        let password = passwordTextField.stringValue

        guard !username.isEmpty, !password.isEmpty
            else {
                self.showMessage("Усі поля повинні бути заповнені")
                return
        }

        let user = User(username: username, password: password, created: Date(), cards: [])
        UsersRealmProvider.SharedInstance.saveUser(user, completion: {
            print("Saved")
        }) { (error) in
            self.showMessage(error.localizedDescription)
        }
    }

    private func showMessage(_ message: String) {
        errorLabel.stringValue = message
        errorLabel.isHidden = false
    }

    // MARK: - Action Handlers

    @IBAction func textFieldAction(_ sender: NSTextField) {
        errorLabel.isHidden = true

        sender.resignFirstResponder()

        if sender == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            registerUser()
        }
    }

    @IBAction func actionLogin(_ sender: NSButton) {
        errorLabel.isHidden = true
        registerUser()
    }
}
