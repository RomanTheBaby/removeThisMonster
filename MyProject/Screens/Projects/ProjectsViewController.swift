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

    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
        flowLayout.sectionInset = NSEdgeInsetsMake(10.0, 20.0, 10.0, 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0

        configureAppearence()
    }

    private func configureAppearence() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blue.cgColor

        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.blue.cgColor
    }
}

//extension ProjectsViewController: NSCollectionViewDataSource {
//    func numberOfSections(in collectionView: NSCollectionView) -> Int {
//        return 0
//    }
//}
