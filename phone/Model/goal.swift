//
//  goals.swift
//  CoolCraig
//
//  Created by InfProjCourse2 on 12/2/19.
//  Copyright © 2019 InfProjCourse2. All rights reserved.
//

import Foundation

class goal {
  var category: String?
  var title: String?
  var points: String?
    var completedGoal : Bool?
  
    //["goalTitle": Stay Focus on Task, "goalCategory": School, "goalPoints": 10]
    init(dictionary: [String : Any]) {
        let category = dictionary["goalCategory"] as? String
        self.category = category
        
        guard let title = dictionary["goalTitle"] as? String else {return}
        self.title = title
        
        guard let points = dictionary["goalPoints"] as? String else {return}
        self.points = points
        
        guard let completedGoal = dictionary["completed"] as? Bool else {return}
        self.completedGoal = completedGoal
            
    }
}

protocol DocumentSerializable {
  init?(dictionary: [String: Any])
}
