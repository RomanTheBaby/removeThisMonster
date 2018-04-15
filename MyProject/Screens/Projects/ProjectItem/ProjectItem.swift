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
        view.layer?.backgroundColor = NSColor.coolPurple.cgColor
        view.layer?.cornerRadius = 10
    }

    func setProjectName(_ name: String) {
        projectNameLabel.stringValue = name
    }
}
