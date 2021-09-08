//
//  WindowController.swift
//  classicPrototype
//
//  Created by atelier on 2021/09/08.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        // Make titlebar transparent.
        window?.titlebarAppearsTransparent = true
        // Change view size to whole window.
        window?.styleMask.insert(.fullSizeContentView)
    }

}
