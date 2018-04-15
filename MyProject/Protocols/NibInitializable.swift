//
//  NibInitializable.swift
//  MyProject
//
//  Created by Baby on 4/15/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

protocol NibInitializable {
    static var nibName: String { get }
    static var nib: NSNib { get }
    static func instantiateFromNib() -> Self
}

extension NibInitializable where Self: NSView {
    static var nibName: String {
        return String(describing: Self.self)
    }

    static var nib: NSNib {
        return NSNib(nibNamed: NSNib.Name(nibName), bundle: nil)!
    }

    static func instantiateFromNib() -> Self {
        var tolLevelObject: NSArray? = NSArray()
        guard nib.instantiate(withOwner: nil, topLevelObjects: &tolLevelObject) else {
                fatalError("Could not instantiate view from nib with name \(nibName).")
        }

        var someView: Self?

        tolLevelObject?.forEach({ (object) in
            if let selfView = object as? Self {
                someView = selfView
            }
        })

        if let viiew = someView {
            return viiew
        } else {
            fatalError("Could not instantiate view from nib with name \(nibName).")
        }
    }
}
