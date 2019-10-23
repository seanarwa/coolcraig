//
//  NewTaskInterfaceController.swift
//  coolcraig WatchKit Extension
//
//  Created by InfProjCourse1 on 10/21/19.
//

import WatchKit
import Foundation


class NewTaskInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var newTaskPicker: WKInterfacePicker!
    
    let pickerData = ["Do Something Extra", "Answer a Survey", "Do a Chore", "Be Social", "Behave", "Sleep", "Exercise"]
    let defaultImage = UIImage(systemName: "photo")

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        let pickerItems: [WKPickerItem] = pickerData.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0
//            pickerItem.contentImage = WKImage(image: defaultImage)
            return pickerItem
        }
        newTaskPicker.setItems(pickerItems)
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
