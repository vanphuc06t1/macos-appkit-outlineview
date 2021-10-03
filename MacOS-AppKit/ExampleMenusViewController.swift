//
//  ExampleMenusViewController.swift
//  MacOS-AppKit
//
//  Created by Phuc Bui  on 9/29/21.
//

import Cocoa

class ExampleMenusViewController: NSViewController {

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

// MARK: Storyboard instantiation
extension ExampleMenusViewController {
    
    static func initalizeMenuController() -> ExampleMenusViewController {
        //1. Get main storybaord
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2. Controller identifier
        let identifier = NSStoryboard.SceneIdentifier("ExampleMenusViewController")
        //3. ExampleMenusViewController
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ExampleMenusViewController else {
            fatalError("Why cant i find ExampleMenusViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

