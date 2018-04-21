//
//  CardItem.swift
//  MyProject
//
//  Created by Baby on 4/21/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

class CardItem: NSCollectionViewItem {

    override func awakeFromNib() {
        super.awakeFromNib()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
    }
}
