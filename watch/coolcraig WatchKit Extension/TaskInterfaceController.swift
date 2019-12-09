//
//  TaskInterfaceController.swift
//  coolcraig WatchKit Extension
//
//  Created by InfProjCourse1 on 11/2/19.
//

import WatchKit
import Foundation


class TaskInterfaceController: WKInterfaceController {

    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var dueDateLabel: WKInterfaceLabel!
    @IBOutlet weak var pointsLabel: WKInterfaceLabel!
    @IBOutlet weak var completeButton: WKInterfaceButton!
    
    var task: Dictionary<String,Any> = [:]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let context = context as! Dictionary<String, Any>
        
        // Configure interface objects here.
        task = context["task"] as? Dictionary<String, Any> ?? [:]
        nameLabel.setText(task["name"] as? String)
        dueDateLabel.setText(task["dueDate"] as? String)
        pointsLabel.setText(String(task["points"] as! Int))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func onCompleteButtonClick() {
        if let url = URL(string: "https://firestore.googleapis.com/v1/\(task["ref"] ?? "")?updateMask.fieldPaths=isComplete") {
            
            let json: [String:Any] = [
                "fields": [
                    "isComplete": [
                        "booleanValue": true
                    ]
                ]
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                var success: Bool = false
                
                if let data = data {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        if responseJSON["error"] == nil {
                            success = true
                            print(responseJSON)
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
}
