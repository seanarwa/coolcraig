//
//  WelcomeInterfaceController.swift
//  coolcraig WatchKit Extension
//
//  Created by InfProjCourse1 on 11/2/19.
//

import WatchKit
import Foundation


class WelcomeInterfaceController: WKInterfaceController {

    @IBOutlet weak var displayNameLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        displayNameLabel.setText(Utils.getKey(key: "userEmail") as? String)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func onNextButtonClick() {
        Utils.navigateToPageAndPop(pageNames: ["HomeInterfaceController","RewardsInterfaceController","MonthlyReportInterfaceController","ProfileInterfaceController","SettingsInterfaceController"])
    }
    
    @IBAction func onNotYouButtonClick() {
        Utils.navigateToPageAndPop(pageNames: ["LoginInterfaceController"])
    }
    
}
