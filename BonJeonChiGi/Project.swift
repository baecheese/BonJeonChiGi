//
//  Project.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 13..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation
import RealmSwift

class Goal: Object {
    dynamic var name:String = ""
    dynamic var value:Double = 0.0
    dynamic var hit:Bool = false
}

class Mission: Object {
    dynamic var name:String = ""
    dynamic var value:Double = 0.0
    dynamic var successCount = 0
    private var missionHistory = List<History>()
    
    func appendMissionHistory(history:History) {
        missionHistory.append(history)
    }
    
}

class History: Object {
    dynamic var dateList:Double = 0.0//TimeInterval
    dynamic var isSuccess = false
    dynamic var comment:String? = nil
}

class Project: Object {
    
    dynamic var id:Int = 0
    dynamic var name:String = ""
    dynamic var unit:String = ""
    dynamic var cycle:Int = 0
    private var goalList = List<Goal>()
    private var missionList = List<Mission>()
    dynamic var startDate:Double = 0.0
    dynamic var hitDate:Double = 0.0
    dynamic var hitAllGoal = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func appendGoal(goal:Goal) {
        self.goalList.append(goal)
    }
    
    func appendMission(mission:Mission) {
        self.missionList.append(mission)
    }
    
    func getMissionList() -> List<Mission> {
        return missionList
    }
    
    func getGoalTotal() -> Double {
        var result = 0.0
        for goal in goalList {
            result += goal.value
        }
        return result
    }
    
    func getMissionTotal() -> Double {
        var result = 0.0
        for mission in missionList {
            result += mission.value
        }
        return result
    }
    
    func getSuccessMissionTotal() -> Double {
        var result = 0.0
        for mission in missionList {
            result += mission.value * Double(mission.successCount)
        }
        return result
    }
    
    func getRemainGoal() -> Double {
        return getGoalTotal() - getSuccessMissionTotal()
    }
    
}
