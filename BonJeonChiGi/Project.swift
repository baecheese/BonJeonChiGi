//
//  Project.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 13..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation
import RealmSwift

class Spend: Object {
    dynamic var name:String = ""
    dynamic var value:Double = 0.0
    dynamic var hit:Bool = false
}

class Mission: Object {
    dynamic var name:String = ""
    dynamic var value:Double = 0.0
    dynamic var successCount = 0
    var history = List<MissionHistroy>()
}

class MissionHistroy: Object {
    dynamic var dateList:Double = 0.0//TimeInterval
    dynamic var isSuccese:Bool = false
    dynamic var comment:String?
}

class Project: Object {
    
    dynamic var id:Int = 0
    dynamic var name:String = ""
    dynamic var unit:String = ""
    dynamic var cycle:Int = 0
    private var spendList = List<Spend>()
    private var missionList = List<Mission>()
    dynamic var startDate:Double = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func appendSpend(spend:Spend) {
        self.spendList.append(spend)
    }
    
    func appendMission(mission:Mission) {
        self.missionList.append(mission)
    }
    
    func getMissionList() -> List<Mission> {
        return missionList
    }
    
    func getSpendTotal() -> Double {
        var result = 0.0
        for spend in spendList {
            result += spend.value
        }
        return result
    }
    
    func getmissionTotal() -> Double {
        var result = 0.0
        for mission in missionList {
            result += mission.value * Double(mission.successCount)
        }
        return result
    }
    
}
