//
//  TaskListInterfaceController.swift
//  coolcraig WatchKit Extension
//
//  Created by InfProjCourse1 on 11/2/19.
//

import WatchKit
import Foundation


class TaskListInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var categoryLabel: WKInterfaceLabel!
    @IBOutlet weak var iconImage: WKInterfaceImage!
    @IBOutlet var taskListTable: WKInterfaceTable!
    
    var tasks: [Dictionary<String,Any>] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let context = context as! Dictionary<String, Any>
        
        // Configure interface objects here.
        tasks = context["tasks"] as? [Dictionary<String, Any>] ?? []
        
        categoryLabel?.setText(context["title"] as? String)
        categoryLabel.setTextColor(context["color"] as? UIColor)
        iconImage?.setImage(UIImage(systemName: context["icon"] as! String))
        iconImage.setTintColor(context["color"] as? UIColor)
        
        taskListTable.setNumberOfRows(tasks.count, withRowType: "TaskListTableRowController")
        for i in 0..<taskListTable.numberOfRows {
            guard let row = taskListTable.rowController(at: i) as? TaskListTableRowController else { continue }
            row.taskLabel.setText(tasks[i]["name"] as? String)
            row.taskLabel.setTextColor(context["color"] as? UIColor)
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        pushController(withName: "TaskInterfaceController", context: ["task": tasks[rowIndex]])
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
