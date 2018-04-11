//
//  NSView+Extension.swift
//  MyProject
//
//  Created by Baby on 4/11/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

extension NSView {
    func setCornetRadius(_ radius: CGFloat = 10.0) {
        wantsLayer = true
        layer?.cornerRadius = radius
    }
}
