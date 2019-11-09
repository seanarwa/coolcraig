//
//  HomeInterfaceController.swift
//  coolcraig WatchKit Extension
//
//  Created by InfProjCourse1 on 11/2/19.
//

import WatchKit
import Foundation


class HomeInterfaceController: WKInterfaceController {
    
    var selectedCategory:Category = Category.none

    @IBOutlet weak var schoolButton: WKInterfaceButton!
    @IBOutlet weak var healthButton: WKInterfaceButton!
    @IBOutlet weak var socialButton: WKInterfaceButton!
    @IBOutlet weak var otherButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func onSchoolButtonClick() { onButtonClick(category: Category.school) }
    
    @IBAction func onHealthButtonClick() { onButtonClick(category: Category.health) }
    
    @IBAction func onSocialButtonClick() { onButtonClick(category: Category.social) }
    
    @IBAction func onOtherButtonClick() { onButtonClick(category: Category.other) }
    
    func onButtonClick(category: Category) {
        selectedCategory = category
        var title: String = "", icon: String = "", color: UIColor = UIColor(), tasks: [Dictionary<String, Any>] = []
        switch category {
        case Category.school:
            title = "School"
            icon = "book"
            color = UIColor(rgb: 0xFF9300)
        case Category.health:
            title = "Health"
            icon = "waveform.path.ecg"
            color = UIColor(rgb: 0xFF2F92)
        case Category.social:
            title = "Social"
            icon = "person.2"
            color = UIColor(rgb: 0x7A81FF)
        case Category.other:
            title = "Other"
            icon = "ellipsis"
            color = UIColor(rgb: 0x00FA92)
        default:
            break
        }
        tasks.append(["title": "TASK 1"])
        tasks = [["title": "TASK 1"],["title": "TASK 2"],["title": "TASK 3"]]
        let context: [String: Any] = [
            "title": title,
            "icon": icon,
            "color": color,
            "tasks": tasks
        ]
        pushController(withName: "TaskListInterfaceController", context: context)
    }
    
//    func getTasksByCategory(category: Category) {
//        switch category {
//        case Category.school:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
}
