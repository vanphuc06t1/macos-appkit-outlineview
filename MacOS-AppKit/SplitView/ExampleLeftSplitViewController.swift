//
//  ExampleLeftSplitViewController.swift
//  MacOS-AppKit
//
//  Created by Phuc Bui  on 10/2/21.
//

import Cocoa

///
/// In left view of Split View I will show you an example of Outline View
///
class ExampleLeftSplitViewController: NSViewController {
    
    @IBOutlet weak var outlineView: NSOutlineView!
    
    let people = [
        Person(name: "Harry Potter", address: "United Kingdom",
                            hobbies: ["Film", "Book"]),
        Person(name: "Wayne Manor", address: "Mountain Drive, Gotham City, USA",
                            hobbies: ["Tennis", "Piano"])
    ]

    lazy var rows = people.map { OutlineViewRow(person: $0) }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.

        self.outlineView.dataSource = self
        self.outlineView.delegate = self
        
    }
    
}

//MARK: - Working with Outline View

extension ExampleLeftSplitViewController : NSOutlineViewDataSource {
    /// Return the item representing each row
    /// If item == nil, it is the root of the outline view and is invisible
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        switch item {
        case nil:
            return self.rows[index]
        case let row as OutlineViewRow:
            return row.children[index]
        default:
            return NSNull()
        }
    }
    
    /// Return the number of children for each row
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        switch item {
        case nil:
            return self.rows.count
        case let row as OutlineViewRow:
            return row.children.count
        default:
            return 0
        }
    }
    
    /// Determine if the row is expandable
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        switch item {
        case let row as OutlineViewRow:
            return !row.children.isEmpty
        default:
            return false
        }
    }

}

extension ExampleLeftSplitViewController : NSOutlineViewDelegate {
    /// Return content of the cell
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let row = item as? OutlineViewRow,
              let column = OutlineViewColumn(tableColumn: tableColumn!)
        else {
            fatalError("Invalid row and column combination")
        }
        
        let text: String
        switch column {
        case .key:
            text = row.key
        case .value:
            text = row.value == nil ? "" : "\(row.value!)"
        }
        
        let identifier = NSUserInterfaceItemIdentifier("outlineViewCell")
        let view = outlineView.makeView(withIdentifier: identifier, owner: self) as! NSTableCellView
        view.textField?.stringValue = text
        
        return view
    }
}


/// The data Model
struct Person {
    var name: String
    var address: String
    var hobbies: [String]
}

// A wrapper object that represents a row in the Outline View
// Since Cocoa Binding relies on the Objective-C runtime, we need to mark this
// class with @objcMembers for dynamic dispatch
@objcMembers class OutlineViewRow: NSObject {
    var key: String                 // content of the Key column
    var value: Any?                 // content of the Value column
    var children: [OutlineViewRow]  // set to an empty array if the row has no children

    init(key: String, value: Any?, children: [OutlineViewRow]) {
        self.key = key
        self.value = value
        self.children = children
    }

    convenience init(person: Person) {
        let hobbies = person.hobbies.map { OutlineViewRow(key: $0, value: nil, children: []) }
        let children = [
            OutlineViewRow(key: "Address", value: person.address, children: []),
            OutlineViewRow(key: "Hobbies", value: nil, children: hobbies)
        ]
        self.init(key: person.name, value: nil, children: children)
    }
}

/// A listing of all available columns in the outline view.
///
/// Since repeating string literals is error prone, we define them in a single location here.
/// The literals must match the column identifiers in the Story Board
enum OutlineViewColumn: String {
    case key = "keyColumn"
    case value = "valueColumn"

    init?(tableColumn: NSTableColumn) {
        self.init(rawValue: tableColumn.identifier.rawValue)
    }
}
