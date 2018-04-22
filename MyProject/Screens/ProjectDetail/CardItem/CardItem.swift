//
//  CardItem.swift
//  MyProject
//
//  Created by Baby on 4/21/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class CardItem: NSCollectionViewItem {

    @IBOutlet weak private var titleLabel: NSTextField!
    @IBOutlet weak private var priorityControl: NSSegmentedControl!
    @IBOutlet weak private var statusControl: NSSegmentedControl!
    @IBOutlet weak private var executersLabel: NSTextField!

    private var card: Card!

    var actionHandler: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        view.wantsLayer = true
        view.layer?.cornerRadius = 1.0
        view.layer?.backgroundColor = NSColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
    }

    @IBAction func priorityChanged(_ sender: NSSegmentedControl) {
        card.priority = sender.selectedSegment
        UsersRealmProvider.SharedInstance.saveCard(card, completion: {
            self.actionHandler?()
        }) { (error) in
            print("Error: ", error.localizedDescription)
        }

    }
    @IBAction func statusChanged(_ sender: NSSegmentedControl) {
        guard let status = CardStatus(rawValue: sender.selectedSegment) else { return }
        card.status = status

        UsersRealmProvider.SharedInstance.saveCard(card, completion: {
            self.actionHandler?()
        }) { (error) in
            print("Error: ", error.localizedDescription)
        }
    }

    func configure(with card: Card, executers: [User]) {
        self.card = card
        titleLabel.stringValue = card.title
        priorityControl.selectedSegment = card.priority
        statusControl.selectedSegment = card.status.rawValue

        let executersNames = executers.map { $0.username }
        executersLabel.stringValue = "  Виконувачі: " + executersNames.joined(separator: ", ")
    }
}
