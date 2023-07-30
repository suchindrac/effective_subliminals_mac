//
//  ViewController.swift
//  Effective Subliminals
//
//  Created by Suchindra Chandrahas on 10/08/21.
//

import Cocoa

class ViewController: NSViewController {

    var buttonHidden = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        self.view.window?.hasShadow = false
        
        var mouseLocation: NSPoint { NSEvent.mouseLocation }
        let window = NSApplication.shared.windows.first
        var location: NSPoint { window!.mouseLocationOutsideOfEventStream }

        NSEvent.addLocalMonitorForEvents(matching: [.rightMouseDown]) {
            print("Toggling Read Messages button")
            if self.buttonHidden == 0 {
                self.readMessagesButton.isHidden = true
                self.buttonHidden = 1
            } else {
                self.readMessagesButton.isHidden = false
                self.buttonHidden = 0
            }
            
            return $0
        }

        let msg = String("")
        self.setLabel(msg: msg)
        self.readMessagesButton.isHidden = false
        let rect = NSScreen.main?.frame
        let width = rect!.size.width
        let height = rect!.size.height
        self.subLabel.setFrameSize(NSSize(width:width, height:height))
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (e) -> NSEvent? in
            if (e.keyCode == 126) {
                self.subLabel.alphaValue += 0.1
            }
            
            if (e.keyCode == 125) {
                self.subLabel.alphaValue -= 0.1
            }
            
            if (e.keyCode == 123) {
                self.subLabel.alphaValue -= 0.01
            }
            
            if (e.keyCode == 124) {
                self.subLabel.alphaValue += 0.01
            }

            return e
        }

    }
    
    @IBOutlet weak var subLabel: NSTextField!
    
    @IBOutlet weak var readMessagesButton: NSButton!
    
    @IBAction func focusOnPane(_ sender: Any) {
        let window = NSApplication.shared.windows.first
        window!.makeKeyAndOrderFront(self)
        self.readMessagesButton.isHidden = false
    }
    @IBAction func readMessages(_ sender: Any) {
        
        let subFile = ".sub_msgs.txt"
        var content = ""
        
        let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
        
        let fileURL = homeDirURL.appendingPathComponent(subFile)
     
        do {
            content = try String(contentsOf: fileURL, encoding: .utf8)
            content = content.replacingOccurrences(of: "\n", with: "")
    
            setLabel(msg: content)
        } catch {/* error handling here */}
        
        self.readMessagesButton.isHidden = true
        
    }
    
    func setLabel(msg: String) {
        
        let subMsg = String(repeating: msg + "    ", count: 100000)
        subLabel.stringValue = subMsg
        // subLabel.textColor = NSColor.blue
        subLabel.textColor = colorWithHexColorString(colorString: "0d0d0d")
        subLabel.alphaValue = 0.03
        let window = NSApplication.shared.windows.first
        window?.ignoresMouseEvents = true

    }
    override var representedObject: Any? {
    didSet {
    // Update the window
    }
}



}

func colorWithHexColorString(colorString: String) -> NSColor?
{
    var color: NSColor? = nil

    var colorCode = UInt32()

    var redByte:CGFloat = 255;
    var greenByte:CGFloat = 255;
    var blueByte: CGFloat = 255;

    let scanner = Scanner(string: colorString)
    if scanner.scanHexInt32(&colorCode) {
        redByte = CGFloat(colorCode & 0xff0000)
        greenByte = CGFloat(colorCode & 0x00ff00)
        blueByte =  CGFloat(colorCode & 0xff)
        color = NSColor(red: redByte, green: greenByte, blue: blueByte, alpha: 1.0)
    }

    return color
}
