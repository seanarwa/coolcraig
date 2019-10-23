//
//  MainInterfaceController.swift
//  coolcraig WatchKit Extension
//
//  Created by InfProjCourse1 on 10/21/19.
//

import WatchKit
import Foundation

class MainInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var taskTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
//        taskTable.setNumberOfRows(10, withRowType: "Row")
//        
//        for i in 0 ..< 10 {
//            guard let row = taskTable.rowController(at: i) as? TaskTableRowController else { continue }
//            row.label.setText("Row \(i+1)")
//        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func addTaskButton() {
        
    }
    
}
