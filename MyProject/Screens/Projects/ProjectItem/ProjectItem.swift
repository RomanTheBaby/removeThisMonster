//
//  ProjectItem.swift
//  MyProject
//
//  Created by Baby on 4/14/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class ProjectItem: NSCollectionViewItem {
    
    @IBOutlet weak private var projectNameLabel: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(red: 125/255, green: 22/255, blue: 126/255, alpha: 1.0).cgColor
    }

    func setProjectName(_ name: String) {
        projectNameLabel.stringValue = name
    }
}
