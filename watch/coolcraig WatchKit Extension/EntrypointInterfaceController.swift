//
//  EntrypointInterfaceController.swift
//  coolcraig WatchKit Extension
//
//  Created by InfProjCourse1 on 11/5/19.
//

import WatchKit
import Foundation


class EntrypointInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    func checkUser() {
        if let url = URL(string: "https://securetoken.googleapis.com/v1/token?key=\(Environment.FIREBASE_API_KEY)") {
            
            let json: [String:Any] = [
                "grant_type": "refresh_token",
                "refresh_token": Utils.getKey(key: "userRefreshToken")
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
                    if let responseJSON = responseJSON as? [String: Any] {
                        if responseJSON["error"] == nil {
                            success = true
                            Utils.storeKey(key: "userRefreshToken", value: responseJSON["refresh_token"])
                            Utils.storeKey(key: "userIdToken", value: responseJSON["id_token"])
                            Utils.storeKey(key: "userId", value: responseJSON["user_id"])
                        } else {
                            success = false
                            print(responseJSON)
                        }
                    }
                } else {
                    success = false
                }
                
                DispatchQueue.main.async {
                    if(success) {
                        print("User is signed in, redirecting to Welcome page ...")
                    } else {
                        print("User is not signed in, redirecting to Login page ...")
                    }
                    Utils.navigateToPageAndPop(pageNames: success ? ["WelcomeInterfaceController"] : ["LoginInterfaceController"])
                }
                
            }.resume()
            
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        checkUser()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
