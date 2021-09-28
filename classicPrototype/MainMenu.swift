//
//  MainMenu.swift
//  classicPrototype
//
//  Created by atelier on 2021/09/27.
//

import Cocoa

class MainMenu: NSObject {
    weak var viewController: ViewController!
    
    @IBAction func pushNewButton(_ sender: Any) {
        print("Hello")
        print(viewController?.saveExecCount)
    }
}
