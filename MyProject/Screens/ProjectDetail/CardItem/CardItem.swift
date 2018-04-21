//
//  CardItem.swift
//  MyProject
//
//  Created by Baby on 4/21/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class CardItem: NSCollectionViewItem {

    @IBOutlet weak var cardNameLabel: NSTextField!
    @IBOutlet weak var priorityLabel: NSTextField!
    @IBOutlet weak var statusButton: NSPopUpButton!
    @IBOutlet weak var executersLabel: NSTextField!

    override func awakeFromNib() {
        super.awakeFromNib()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
    }

    func configure(with card: Card) {
        cardNameLabel.stringValue = card.title

        CardStatus.All.forEach { statusButton.addItem(withTitle: $0.localizedDescription) }
        statusButton.selectItem(withTitle: card.status.localizedDescription)

    }
}
