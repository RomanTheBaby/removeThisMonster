//
//  NSColor+Extension.swift
//  MyProject
//
//  Created by Baby on 4/11/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

extension NSColor {
    class var blue: NSColor {
        return NSColor(red: 18/255, green: 122/255, blue: 189/255, alpha: 1.0)
    }

    class var darkBlue: NSColor {
        return NSColor(red: 15/255, green: 104/255, blue: 161/255, alpha: 1.0)
    }

    class var lightGreen: NSColor {
        return NSColor(red: 95/255, green: 179/255, blue: 81/255, alpha: 1.0)
    }

    class var coolPurple: NSColor {
        return NSColor(red: 125/255, green: 22/255, blue: 126/255, alpha: 1.0)
    }

    class func randomProjectColor() -> NSColor {
        let colors: [NSColor] = [.darkBlue, .lightGreen, .coolPurple, .black, .brown, .red, .cyan, .darkGray, .orange, .yellow]

        let count = colors.count - 1

        let length = Int64(count - 1)
        let index = Int64(arc4random()) % length + Int64(0)

        return colors[Int(index)]
    }
}

extension NSObject {
    public func randomNumber<T : SignedInteger>(inRange range: ClosedRange<T> = 1...6) -> T {
        let length = Int64(range.upperBound - range.lowerBound + 1)
        let value = Int64(arc4random()) % length + Int64(range.lowerBound)
        return T(value)
    }
}
