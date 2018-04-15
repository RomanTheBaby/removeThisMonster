//
//  ProjectsViewController.swift
//  MyProject
//
//  Created by Baby on 4/14/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class ProjectsViewController: NSViewController {

    @IBOutlet weak private var collectionView: NSScrollView!

    private let addingAlertView = ProdjectAlertView.instantiateFromNib()

    override func viewDidLoad() {
        super.viewDidLoad()

        addingAlertView.dismiss = {
            self.addingAlertView.removeFromSuperview()
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
        flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
        flowLayout.sectionInset = NSEdgeInsetsMake(10.0, 20.0, 10.0, 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
    }

    @IBAction private func actionAddProdject(_ sender: NSButton) {
        addingAlertView.removeFromSuperview()

        view.addSubview(addingAlertView)

        var currentFrame = addingAlertView.frame
        currentFrame.origin.x = NSMidX(view.frame) - currentFrame.width / 2.0
        currentFrame.origin.y = NSMidY(view.frame) - currentFrame.height / 2.0
        addingAlertView.frame = currentFrame
    }
}

//extension ProjectsViewController: NSCollectionViewDataSource {
//    func numberOfSections(in collectionView: NSCollectionView) -> Int {
//        return 0
//    }
//}
