//
//  SettingsInterfaceController.swift
//  coolcraig WatchKit Extension
//
//  Created by InfProjCourse1 on 11/13/19.
//

import WatchKit
import Foundation


class SettingsInterfaceController: WKInterfaceController {

    @IBOutlet weak var textSwitch: WKInterfaceSwitch!
    @IBOutlet weak var vibrateSwitch: WKInterfaceSwitch!
    @IBOutlet weak var surveySwitch: WKInterfaceSwitch!
    @IBOutlet weak var reminderSwitch: WKInterfaceSwitch!
    @IBOutlet weak var muteAllSwitch: WKInterfaceSwitch!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        print(Utils.getKey(key: "notificationSurvey", defaultValue: true))
        textSwitch.setOn(Utils.getKey(key: "notificationText", defaultValue: false) as! Bool)
        vibrateSwitch.setOn(Utils.getKey(key: "notificationVibrate", defaultValue: true) as! Bool)
        surveySwitch.setOn(Utils.getKey(key: "notificationSurvey", defaultValue: true) as! Bool)
        reminderSwitch.setOn(Utils.getKey(key: "notificationReminder", defaultValue: true) as! Bool)
        let muteAll = Utils.getKey(key: "notificationMuteAll", defaultValue: false) as! Bool
        setSwitchesEnabled(enabled: !muteAll)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func setSwitchesEnabled(enabled: Bool) {
        textSwitch.setEnabled(enabled)
        vibrateSwitch.setEnabled(enabled)
        surveySwitch.setEnabled(enabled)
        reminderSwitch.setEnabled(enabled)
    }
    
    @IBAction func onTextSwitchAction(_ value: Bool) {
        Utils.storeKey(key: "notificationText", value: value)
    }
    
    @IBAction func onVibrateSwitchAction(_ value: Bool) {
        Utils.storeKey(key: "notificationVibrate", value: value)
    }
    
    @IBAction func onSurveySwitchAction(_ value: Bool) {
        Utils.storeKey(key: "notificationSurvey", value: value)
    }
    
    @IBAction func onReminderSwitchAction(_ value: Bool) {
        Utils.storeKey(key: "notificationReminder", value: value)
    }
    
    @IBAction func onMuteAllSwitchAction(_ value: Bool) {
        Utils.storeKey(key: "notificationMuteAll", value: value)
        setSwitchesEnabled(enabled: !value)
    }
    
}
