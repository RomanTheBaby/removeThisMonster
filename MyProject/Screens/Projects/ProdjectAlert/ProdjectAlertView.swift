//
//  ProdjectAlertView.swift
//  MyProject
//
//  Created by Baby on 4/14/18.
//  Copyright © 2018 Alina. All rights reserved.
//

import Cocoa

final class ProdjectAlertView: NSView, NibInitializable {

    var completion: (() -> Void)?
    var error: ((Error) -> Void)?
    var dismiss: (() -> Void)?

    @IBOutlet weak var nameTextField: NSTextField!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        wantsLayer = true
        layer?.backgroundColor = NSColor.blue.cgColor
        layer?.borderWidth = 1.0
        layer?.borderColor = NSColor.black.cgColor
    }
    
    @IBAction private func actionCancel(_ sender: NSButton) {
        dismiss?()
    }

    @IBAction private func actionConfirm(_ sender: NSButton) {
        createProdject(named: nameTextField.stringValue)
    }
    @IBAction private func textFieldAction(_ sender: NSTextField) {
        createProdject(named: sender.stringValue)
    }

    private func createProdject(named name: String) {
        guard !name.isEmpty else { dismiss?(); return }
        let project = Project(projName: name)
        ProdjectsRealmProvider.SharedInstance.saveProdject(project, completion: { [weak self] in
            self?.completion?()
        }) { [weak self] (err) in
            self?.error?(err)
        }
    }
}
