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
        signInButton.layer?.backgroundColor = NSColor.darkBlue.cgColor
        signInButton.attributedTitle = NSAttributedString(string: "Увійти",
                                                          attributes: [.foregroundColor: NSColor.white,
                                                                       .paragraphStyle: pstyle])

        errorLabel.isHidden = true
        errorLabel.wantsLayer = true
        errorLabel.layer?.cornerRadius = 10
        errorLabel.layer?.backgroundColor = NSColor.red.cgColor
    }

    private func authUser() {
        let username = usernameTextField.stringValue
        let password = passwordTextField.stringValue

        guard !username.isEmpty, !password.isEmpty
            else {
                self.showMessage("Усі поля повинні бути заповнені")
                return
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
            authUser()
        }
    }

    @IBAction func actionLogin(_ sender: NSButton) {
        errorLabel.isHidden = true

        authUser()
    }

}

extension AuthViewController: NSTextFieldDelegate {
}
