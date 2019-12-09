//
//  AddNewRewardViewController.swift
//  CoolCraig
//
//  Created by InfProjCourse2 on 11/19/19.
//  Copyright © 2019 InfProjCourse2. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import Firebase


class AddNewRewardViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var pointsTextField: UITextField!
    
    @IBOutlet weak var createNewRewardButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(titleTextField)
        Utilities.styleTextField(pointsTextField)
        Utilities.styleFilledButton(createNewRewardButton)
    }
    
    func validateFields() -> String? {
    
    // check that all fields are filled in
        if titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  pointsTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all the fileds!"
        }
        return nil
        
    }
    
    func transitionToRewardTableViewController() {
        let rewardTableViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.rewardTableViewController) as? RewardsTableViewController
        
        view.window?.rootViewController = rewardTableViewController
        view.window?.makeKeyAndVisible()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func createNewRewardButtonTapped(_ sender: Any) {
            let title = titleTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   
            let points = pointsTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let db = Firestore.firestore()
                   let currentUserID = Auth.auth().currentUser!.uid
                   let docRef = db.collection("users").document(currentUserID)
                   let param : [String:Any] = [
                   "rewardTitle": title,
                   "rewardPoints": points,
                   "claimed" : false]
                   docRef.updateData(["rewards": FieldValue.arrayUnion([param])])
                    { err in
                       if let err = err {
                           print("Error writing document: \(err)")
                       } else {
                           print("Document successfully updated!")
                       }
                   }
                  transitionToRewardTableViewController()
               }
}
