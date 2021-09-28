//
//  ViewController.swift
//  classicPrototype
//
//  Created by atelier on 2021/09/08.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {
    
    @IBOutlet var textEditor: NSTextView!
    
    // Input text relations
    var inputText: String = ""
    
    // File save path relations
    var saveFilename: String = ""
    let documentDirectoryPath = NSHomeDirectory() + "/Documents"
 
    // File save timer relations
    var timer: Timer!
    var saveCounter: Int = 0
    let saveExecCount: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEditor.delegate = self
        
        // Load newest file.
        loadLatestFileInfo()

        // Appearance restrict light mode.
        NSApp.appearance = NSAppearance(named: .aqua)
    }
    
    func textDidChange(_ notification: Notification) {
        // Get the value written in a text editor.
        guard let textView = notification.object as? NSTextView else { return }
        inputText = textView.string
        
        // Start save timer.
        saveCounter = 0
        
        if(timer != nil) {
            timer.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(saveText),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func saveText() {
        saveCounter += 1

        if(saveCounter == saveExecCount) {
            // Timer init.
            timer.invalidate()
            timer = nil

            // Text save logic.
            let fm = FileManager.default
            let saveFilePath = documentDirectoryPath + "/" + saveFilename
            let textData = inputText.data(using: .utf8)!

            fm.createFile(
                atPath: saveFilePath,
                contents: textData, attributes: nil
            )
        }
    }
    
    func loadLatestFileInfo() {
        do {
            let fm = FileManager.default
            let fileList: Array = try fm.contentsOfDirectory(atPath: NSHomeDirectory() + "/Documents")
            let filteredFileList: Array = fileList.filter {
                $0.contains(".md") &&
                Int($0.components(separatedBy: ".")[0]) != nil
            }

            // Load latest file or create file.
            if (filteredFileList.count == 0) {
                saveFilename = "1.md"
                fm.createFile(
                    atPath:  documentDirectoryPath + "/" + saveFilename,
                    contents: "".data(using: .utf8)!, attributes: nil
                )
            } else {
                // Specify the latest file.
                let fileNumberList: Array = filteredFileList.map {
                    Int($0.components(separatedBy: ".")[0])!
                }
                saveFilename = String(fileNumberList.max()!) + ".md"
                
                // Load Text from latest file.
                textEditor.string = try String(
                    contentsOfFile: documentDirectoryPath + "/" + saveFilename,
                    encoding: String.Encoding.utf8
                )
            }
        } catch {
           print(error)
        }
    }
    
    @IBAction func pushNewPageButton(_ sender: Any) {
        let fm = FileManager.default
        let newFileNumber: Int = Int(saveFilename.components(separatedBy: ".")[0])! + 1
        let newFilename: String = String(newFileNumber) + ".md"
        
        fm.createFile(
            atPath:  documentDirectoryPath + "/" + newFilename,
            contents: "".data(using: .utf8)!, attributes: nil
        )
        
        loadLatestFileInfo()
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
