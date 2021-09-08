//
//  ViewController.swift
//  classicPrototype
//
//  Created by atelier on 2021/09/08.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var textEditor: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

