//
//  ProjectDetailViewController.swift
//  MyProject
//
//  Created by Baby on 4/21/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class ProjectDetailViewController: NSViewController {

    var project: Project!

    @IBOutlet weak private var todoCollectionView: NSCollectionView!
    @IBOutlet weak private var inProgressCollectionView: NSCollectionView!
    @IBOutlet weak private var doneCollectionView: NSCollectionView!

    static let SegueIdentifier = "ShowAddCardView"

    private var allCards: [Card] {
        return UsersRealmProvider.SharedInstance.cards(for: project)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = project.name

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blue.cgColor
    }

    private func cards(with status: CardStatus) -> [Card] {
        let allItems = allCards
        return allItems.filter { $0.status == status }
    }

    private func cards(for collectionView: NSCollectionView) -> [Card] {
        if collectionView == todoCollectionView {
            return cards(with: .toDo)
        } else if collectionView == inProgressCollectionView {
            return cards(with: .inProgress)
        } else {
            return cards(with: .done)
        }
    }

    @IBAction private func actionAddCard(_ sender: NSButton) {
        performSegue(withIdentifier: NSStoryboardSegue.Identifier.init("ShowAddCardView"), sender: nil)
    }
}

extension ProjectDetailViewController: NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards(for: collectionView).count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let allCards = cards(for: collectionView)
        let cardItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CardItem"), for: indexPath) as! CardItem
        let card = allCards[indexPath.item]
        cardItem.configure(with: card)
        return cardItem
    }
}
