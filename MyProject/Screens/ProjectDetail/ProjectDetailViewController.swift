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

    private let availableUsers = UsersRealmProvider.SharedInstance.fetchAllUsers()

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = NSCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10.0
        layout.itemSize = NSSize(width: 290, height: 150)
        layout.sectionInset = NSEdgeInsets(top: 10, left: 5, bottom: 10, right: 5.0)
        todoCollectionView.collectionViewLayout = layout
        (inProgressCollectionView.collectionViewLayout as? NSCollectionViewFlowLayout)?.itemSize = NSSize(width: 290, height: 150)
        (doneCollectionView.collectionViewLayout as? NSCollectionViewFlowLayout)?.itemSize = NSSize(width: 290, height: 150)

//        inProgressCollectionView.collectionViewLayout = layout
//        doneCollectionView.collectionViewLayout = layout

        title = project.name

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blue.cgColor
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        todoCollectionView.reloadData()
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

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destinationController as? AddCardViewController else { return }
        viewController.project = project
    }

    private func reloadAllData() {
        todoCollectionView.reloadData()
        inProgressCollectionView.reloadData()
        doneCollectionView.reloadData()
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
        print(availableUsers.map { user in (user.username, user.cards.map { ($0.created.asKey, $0.title) }) })
        print(card.created.asKey)
        cardItem.configure(with: card, executers: availableUsers.filter { user in user.cards.index(where: { $0.created.asKey == card.created.asKey }) != nil })

        cardItem.actionHandler = { self.reloadAllData() }
        return cardItem
    }
}
