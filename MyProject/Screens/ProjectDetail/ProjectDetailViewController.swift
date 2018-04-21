//
//  ProjectDetailViewController.swift
//  MyProject
//
//  Created by Baby on 4/21/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class ProjectDetailViewController: NSViewController {

    var project: Project?

    static let Segueidentifier = "ShowAddCardView"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = project?.name

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blue.cgColor
    }
}
