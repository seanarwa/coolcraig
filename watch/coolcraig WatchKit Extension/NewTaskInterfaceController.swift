//
//  NewTaskInterfaceController.swift
//  coolcraig WatchKit Extension
//
//  Created by InfProjCourse1 on 10/21/19.
//

import WatchKit
import Foundation


class NewTaskInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var categoryPicker: WKInterfacePicker!
    @IBOutlet weak var goalPicker: WKInterfacePicker!
    @IBOutlet weak var addButton: WKInterfaceButton!
    
    let categories = ["School", "Health", "Social", "Others"]
    let goals = [["Be focused in class", "Bring school material","Bring lunch","Bring PE clothes","Write your name","Stay seated","Participate in class","Organize your belongings","Don't talk in class","Raise your hand before you speak"],["Take a stroll","Take a deep breath","Get dressed","Brush teeth","Clean clothes","Tie your shoes","Use deodorant","Wash your hair","Eat without complaining","Finish lunch box","Eat healthy","Exercise","Take medication"],["Say something nice to someone","Play outside","Don't be alone during breaks","Regulate emotions","Be assertive"],["Clean your room","Empty dish washer","Throw out trash"]]
    let defaultImage = UIImage(systemName: "photo")

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        categoryPicker.setItems(categories.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0
            pickerItem.caption = "Category"
            return pickerItem
        })
        setGoalsByIndex(0)
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func onCategorySelect(_ value: Int) {
        setGoalsByIndex(value)
    }
    
    func setGoalsByIndex(_ index: Int) {
        goalPicker.setItems(goals[index].map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0
            pickerItem.caption = "Goal"
            return pickerItem
        })
    }
    
    @IBAction func onAddButtonClick() {
        
        setLoading(isLoading: true)
        
        let idToken = Utils.getKey(key: "userIdToken")
        
        if let url = URL(string: "https://coolcraig-bdd39.firebaseio.com/goals.json?auth=\(idToken)") {
            
            let json: [String:Any] = [
                "user_id": Utils.getKey(key: "userId")
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                var success: Bool = false
                
                if let data = data {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    print(responseJSON)
                    if let responseJSON = responseJSON as? [String: Any] {
                        if responseJSON["error"] == nil {
                            success = true
                        }
                    }
                } else {
                    print(error as! String)
                }
                
                DispatchQueue.main.async {
                    if(success) {
                        self.pop()
                    }
                    self.setLoading(isLoading: false)
                }
                
            }.resume()
            
        }
        
    }
    
    func setLoading(isLoading: Bool) {
        addButton.setEnabled(!isLoading)
        if(isLoading) {
            
        } else {
            
        }
    }
    
}
