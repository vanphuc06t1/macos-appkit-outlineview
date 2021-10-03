//
//  ExampleSplitViewController.swift
//  MacOS-AppKit
//
//  Created by Phuc Bui  on 10/2/21.
//

import Foundation
import AppKit

class ExampleSplitViewController : NSSplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
}

extension ExampleSplitViewController {
    
    static func initalizeSplitController() -> ExampleSplitViewController {
        //1. Get main storybaord
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2. Controller identifier
        let identifier = NSStoryboard.SceneIdentifier("ExampleSplitViewController")
        //3. ExampleSplitViewController
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ExampleSplitViewController else {
            fatalError("Why cant i find ExampleSplitViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

//MARK: - NSSplitViewDelegate
extension ExampleSplitViewController  {
    

}
