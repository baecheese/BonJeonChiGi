//
//  ProjectRepository.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 13..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectRepository: NSObject {
    private let log = Logger(logPlace: BillRepository.self)
    
    private override init() {
        super.init()
    }
    
    static let sharedInstance:ProjectRepository = ProjectRepository()
    private var realm = try! Realm()
    
    
    func getAll() -> Results<Project> {
        let prjects:Results<Project> = realm.objects(Project.self)
        return prjects
    }
    
    func findOne(id:Int) -> Project? {
        let selectedProject = realm.objects(Project.self).filter("id = \(id)")
        if (selectedProject.isEmpty) {
            return nil
        }
        return selectedProject[0]
    }
    
    func saveBill(name:String, unit:String, cycle:Int, spends:[[String:Double]], missions:[[String:Double]], startDate:Double) -> Bool {
        let project = Project()
        var latestId = 0
        do {
            try realm.write {
                if (false == realm.isEmpty) {
                    latestId = (realm.objects(Bill.self).max(ofProperty: "id") as Int?)!
                    latestId += 1
                    project.id = latestId
                }
                else if (true == realm.isEmpty) {
                    project.id = latestId
                }
                
                project.name = name
                
                for oneSpend in spends {
                    let spend = Spend()
                    spend.name = oneSpend.keys.first!
                    spend.value = oneSpend.values.first!
                    project.appendSpend(spend: spend)
                }
                
                for oneMission in missions {
                    let mission = Mission()
                    mission.name = oneMission.keys.first!
                    mission.value = oneMission.values.first!
                    project.appendMission(mission: mission)
                }
                
                project.startDate = startDate
                
                realm.add(project)
            }
        }
        catch ContentsSaveError.contentsIsEmpty {
            log.warn(message: "contentsIsEmpty")
            return false
        }
        catch {
            log.error(message: "error")
            return false
        }
        log.info(message: "project : \(project)")
        return true
    }
    
    //
    func edit(id:Int, name:String, unit:String, cycle:Int, spends:[[String:Double]], missions:[[String:Double]], startDate:Double) -> Bool {
        let project = findOne(id: id)
        do {
            try realm.write {
                
            }
        }
        catch {
            log.error(message: "realm error on")
            return false
        }
        return true
    }
    
    func delete(prject:Project) {
        try! realm.write {
            log.debug(message: "\(String(describing: prject)) 삭제")
            realm.delete(prject)
        }
    }
    
    func delete(id:Int) {
        let bill = findOne(id: id)!
        try! realm.write {
            log.debug(message: "\(String(describing: bill)) 삭제")
            realm.delete(bill)
        }
    }
    
    
    
}

struct ProgressNames {
    // 이후에 gobal 언어 처리 cheeseing
    let get = [
        ProgressKey.projectName:"프로젝트명"
        , ProgressKey.spendTotal:"총 지출"
        , ProgressKey.missionTotal:"총 수익"
        , ProgressKey.remaining: "남은 본전"
        , ProgressKey.unit:"단위"
        , ProgressKey.cycle:"주기"
        , ProgressKey.startDate:"시작 날짜"
    ]
}

enum ProgressKey {
    case projectName
    case spendTotal
    case missionTotal
    case remaining
    case unit
    case cycle
    case startDate
}

enum ContentsSaveError : Error {
    case contentsIsEmpty
}
