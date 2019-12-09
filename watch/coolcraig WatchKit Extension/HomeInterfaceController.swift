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
    var tasks: [Dictionary<String,Any>] = []

    @IBOutlet weak var schoolButton: WKInterfaceButton!
    @IBOutlet weak var healthButton: WKInterfaceButton!
    @IBOutlet weak var socialButton: WKInterfaceButton!
    @IBOutlet weak var otherButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        fetchTasks()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func fetchTasks() {
        if let url = URL(string: "https://firestore.googleapis.com/v1/projects/coolcraig-bdd39/databases/(default)/documents/users/\(Utils.getKey(key: "userId"))") {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                var success: Bool = false
                
                if let data = data {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        if responseJSON["error"] == nil {
                            success = true
                            var goals = (responseJSON as NSDictionary).value(forKeyPath: "fields.goals.arrayValue.values") as! [[String: Any]]
                            for goal in goals {
                                self.fetchTask(refValue: goal["referenceValue"] as! String)
                            }
                        } else {
                            success = false
                            print(responseJSON)
                        }
                    }
                } else {
                    success = false
                }
                
                DispatchQueue.main.async {
                    // main thread
                }
                
            }.resume()
            
        }
    }
    
    func fetchTask(refValue: String) {
        if let url = URL(string: "https://firestore.googleapis.com/v1/\(refValue)") {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                var success: Bool = false
                
                if let data = data {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        if responseJSON["error"] == nil {
                            success = true
                            var task = (responseJSON as NSDictionary).value(forKeyPath: "fields") as! [String: Any]
                            task = Utils.normalize(dict: task)
                            task["ref"] = refValue
                            self.tasks.append(task)
                            print(task)
                        } else {
                            success = false
                            print(responseJSON)
                        }
                    }
                } else {
                    success = false
                }
                
                DispatchQueue.main.async {
                    // main thread
                }
                
            }.resume()
            
        }
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
        var parsedTasks: [[String: Any]] = []
        for task in self.tasks {
            let category: String = task["category"] as! String
            if(category == title) {
                parsedTasks.append(task)
            }
        }
        let context: [String: Any] = [
            "title": title,
            "icon": icon,
            "color": color,
            "tasks": parsedTasks
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
