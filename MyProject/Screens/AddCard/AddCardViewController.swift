
//
//  AddCardViewController.swift
//  MyProject
//
//  Created by Baby on 4/22/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class AddCardViewController: NSViewController {

    @IBOutlet weak private var titleLabel: NSTextField!
    @IBOutlet weak private var priorityButton: NSSegmentedControl!
    @IBOutlet weak private var searchField: NSSearchField!
    @IBOutlet weak private var selectedUsersLabel: NSTextField!

    var project: Project!
    private let availableUsers = UsersRealmProvider.SharedInstance.fetchAllUsers()

    private var selectedUsers = [User]()
    var userNames: [String] {
        return availableUsers.map { $0.username.lowercased() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        searchField.maximumRecents = 200
        searchField.recentSearches = userNames
    }

    @IBAction private func buttonActionAddUser(_ sender: NSButton) {
        let enteredName = searchField.stringValue.lowercased()
        addUserToCard(named: enteredName)
    }

    @IBAction private func actionAddUser(_ sender: NSSearchFieldCell) {
        let enteredName = sender.stringValue.lowercased()
        addUserToCard(named: enteredName)
    }

    @IBAction private func actionCancel(_ sender: NSButton) {
        dismissViewController(self)
    }

    @IBAction private func actionCreateCard(_ sender: NSButton) {
        if titleLabel.stringValue.isEmpty {
            showAlert(for: "Введіть назву картки!")
            return
        }

        if selectedUsers.isEmpty {
            showAlert(for: "Додайте хоча б одного користувача!")
            return
        }

        let card = Card(title: titleLabel.stringValue, status: .toDo, created: Date().asKey,
                        priority:  priorityButton.selectedSegment, projectId: project.created.asKey,
                        description: titleLabel.stringValue)


        var usersCount = 0
        UsersRealmProvider.SharedInstance.saveCard(card, completion: {
            self.selectedUsers.forEach({ (user) in
                var mutatedUser = user
                mutatedUser.cards.append(card.created)
                UsersRealmProvider.SharedInstance.saveUser(mutatedUser, update: true, completion: {
                    usersCount += 1
                    if usersCount == self.selectedUsers.count - 1 {
                        let parent = self.parent as? ProjectDetailViewController
                        parent?.reloadAllData()
                        self.dismissViewController(self)
                    }
                }, error: { (err) in
                    self.showAlert(for: err)
                })
            })

        }) { (err) in
            self.showAlert(for: err)
        }
    }

    private func addUserToCard(named username: String) {
        if let userIndex = userNames.index(of: username) {
            let user = availableUsers[userIndex]
            if selectedUsers.index(of: user) == nil {
                selectedUsers.append(user)
                selectedUsersLabel.stringValue += user.username + " "
            } else {
                self.showAlert(for: "Користувач вже доданий!")
            }
        } else {
            self.showAlert(for: "Користувача з таким імям не існує!")
        }
    }
}

extension NSTextView {
    open override func hitTest(_ point: NSPoint) -> NSView? {
        return nil
    }
}
