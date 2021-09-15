//
//  ViewController.swift
//  classicPrototype
//
//  Created by atelier on 2021/09/08.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {
    
    @IBOutlet var textEditor: NSTextView!
    
    var timer: Timer!
    var inputText: String = ""
    var saveFilename: String = "1.md"
    var saveCounter: Int = 0
    let saveTargetCount: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEditor.delegate = self
        
        // Appearance restrict light mode.
        NSApp.appearance = NSAppearance(named: .aqua)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func textDidChange(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }
        inputText = textView.string
        
        saveCounter = 0
        controlTimer()
    }
    
    func controlTimer() {
        if(timer != nil) {
            timer.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(judgeSaveText),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func judgeSaveText() {
        saveCounter += 1
        
        if(saveCounter == saveTargetCount) {
            timer.invalidate()
            timer = nil

            do {
                let fm = FileManager.default
                let documentDirectory = try fm.url(
                    for: .documentDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil, create: false
                )
                let saveFilePath = documentDirectory.appendingPathComponent(saveFilename)
                let textData = inputText.data(using: .utf8)!

                fm.createFile(
                    atPath: saveFilePath.path,
                    contents: textData, attributes: nil
                )
            } catch {
                print(error)
            }
        }
    }
}
