//
//  AppDelegate.swift
//  MacOS-AppKit
//
//  Created by Phuc Bui  on 9/29/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    //@IBOutlet weak var customMenu: NSMenuItem!
    
    var window: NSWindow?


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //Init window
        initalizeWindow()
        
        //Examples
        //exampleMenusWindow()
        
        //Example add top menu
        //constructMenu()
        
        //Now let move to Split View and Outline View example
        exampleSplitWindow()
        
        
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        print("Documents Directory: " + "\(paths[0])")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func initalizeWindow() {
        
        let screenSize = NSScreen.main?.frame.size ?? .zero
        
        let windowSize = NSSize(width: screenSize.width, height: screenSize.height)
        
        let rect = NSMakeRect(screenSize.width/2 - windowSize.width/2,
          screenSize.height/2 - windowSize.height/2,
          windowSize.width,
          windowSize.height)
        window = NSWindow(contentRect: rect,
          styleMask: [.miniaturizable, .closable, .resizable, .titled],
          backing: .buffered,
          defer: false)
        
        window?.makeKeyAndOrderFront(nil)
    }
    

}

//MARK: - Examples
extension AppDelegate {
    
    func exampleMenusWindow() {
        
        let exampleMenusViewController = ExampleMenusViewController.initalizeMenuController()
        window?.contentViewController = exampleMenusViewController
    }
    
    func exampleSplitWindow() {
        let splitViewController = ExampleSplitViewController.initalizeSplitController()
        window?.contentViewController = splitViewController
    }
}

//MARK: - Menu Bar Menus
extension AppDelegate {
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Edit", action: #selector(AppDelegate.editAction(_:)), keyEquivalent: "E"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Delete", action: #selector(AppDelegate.deleteAction(_:)), keyEquivalent: "D"))
        
        let customMenu = NSMenuItem(title: "Custom Menu", action: nil, keyEquivalent: "")
        customMenu.submenu = menu
        //Add custom menu to app help menu
        NSApplication.shared.helpMenu?.addItem(customMenu)
    }
    
    @objc private func editAction(_ sender: Any?) {
        print("click custom menu Edit")
    }
    
    @objc private func deleteAction(_ sender: Any?) {
        print("click custom menu Delete")
    }
}

