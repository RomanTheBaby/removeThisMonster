//
//  ProjectsViewController.swift
//  MyProject
//
//  Created by Baby on 4/14/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class ProjectsViewController: NSViewController {

    @IBOutlet weak private var collectionView: NSCollectionView!

    private let addingAlertView = ProdjectAlertView.instantiateFromNib()

    private let SegueIdentifier = "ShowProject"
    private var selectedProject: Project?

    private var projects: [Project] {
        return ProdjectsRealmProvider.SharedInstance.fetchAllProdjects()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addingAlertView.dismiss = {
            self.addingAlertView.removeFromSuperview()
        }

        addingAlertView.completion = {
            self.addingAlertView.removeFromSuperview()
            self.collectionView.reloadData()
        }

        addingAlertView.error = { error in
            self.addingAlertView.removeFromSuperview()

            self.showAlert(for: error)
        }

        configureAppearence()
        configureLayout()
    }

    private func configureAppearence() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blue.cgColor

        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.blue.cgColor
    }

    private func configureLayout() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 250, height: 140.0)
        flowLayout.sectionInset = NSEdgeInsetsMake(10.0, 5.0, 10.0, 5.0)
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.minimumLineSpacing = 5.0
        collectionView.collectionViewLayout = flowLayout
        collectionView.layer?.backgroundColor = NSColor.blue.cgColor
    }

    @IBAction func actionDeleteAll(_ sender: NSButton) {
        UsersRealmProvider.SharedInstance.deleteAllCards()
        ProdjectsRealmProvider.SharedInstance.removeAllProjects()
        view.window?.close()
    }

    @IBAction private func actionAddProdject(_ sender: NSButton) {
        addingAlertView.removeFromSuperview()

        view.addSubview(addingAlertView)

        addingAlertView.nameTextField.stringValue = ""

        var currentFrame = addingAlertView.frame
        currentFrame.origin.x = NSMidX(view.frame) - currentFrame.width / 2.0
        currentFrame.origin.y = NSMidY(view.frame) - currentFrame.height / 2.0
        addingAlertView.frame = currentFrame
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destinationController as? ProjectDetailViewController else { return }
        viewController.project = selectedProject
    }
}

extension ProjectsViewController: NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let projectItem = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ProjectItem"), for: indexPath) as! ProjectItem

        let project = projects[indexPath.item]
        projectItem.setProject(project)

        return projectItem
    }
}

extension ProjectsViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else { return }
        selectedProject = projects[indexPath.item]
        self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(self.SegueIdentifier), sender: nil)
        view.window?.close()
    }
}
