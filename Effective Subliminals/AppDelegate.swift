//
//  AppDelegate.swift
//  Effective Subliminals
//
//  Created by Suchindra Chandrahas on 10/08/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var item: NSStatusItem? = nil
    
    // var vc: ViewController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let window = NSApplication.shared.windows.first
        window?.isOpaque = false
        window?.backgroundColor = .clear
        window?.level = NSWindow.Level.popUpMenu
        
        item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let itemImage = NSImage(named: "subliminal")
        itemImage?.size = NSMakeSize(18.0, 18.0)

        itemImage?.isTemplate = true

        self.item?.button?.image = itemImage
        self.item?.button?.action = #selector(AppDelegate.mainAction)

        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Focus on pane", action: #selector(AppDelegate.reloadMessages), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Exit", action: #selector(AppDelegate.exit), keyEquivalent: ""))

        item?.menu = menu
        
        // vc?.readMessagesButton.isHidden = true
        
        window?.ignoresMouseEvents = true
        window?.backgroundColor = NSColor(red: 1, green: 1, blue: 1, alpha: 0.5)

        let rect = NSScreen.main?.frame
        let width = rect!.size.width
        let height = rect!.size.height
        
        window?.setContentSize(NSSize(width:width, height:height))
        window?.isMovable = false
        window?.setFrameOrigin(NSPoint(x: 0.0, y:0.0))
    }

    @objc func mainAction() {
        print("Inside subliminal")
    }

    @objc func exit() {
        NSApplication.shared.terminate(self)

    }

    @objc func reloadMessages() {
        // vc?.readMessagesButton.isHidden = false
        let window = NSApplication.shared.windows.first
        window?.ignoresMouseEvents = false
        
    }

    func applicationDidBecomeActive(_ notification: Notification) {


    }
    func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
    }
}

