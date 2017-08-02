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
    private let log = Logger(logPlace: ProjectRepository.self)
    
    private override init() {
        super.init()
    }
    
    static let sharedInstance:ProjectRepository = ProjectRepository()
    private var realm = try! Realm()
    
    
    func findAll() -> Results<Project> {
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
    
    func save(project:Project) -> Bool {
        var latestId = 0
        do {
            try realm.write {
                if (false == realm.objects(Project.self).isEmpty) {
                    latestId = (realm.objects(Project.self).max(ofProperty: "id") as Int?)!
                    latestId += 1
                    project.id = latestId
                }
                else {
                    project.id = latestId
                }
                
                realm.add(project)
            }
        }
        catch ContentsSaveError.contentsIsEmpty {
            log.warn(message: "contentsIsEmpty")
            return false
        }
        catch {
            log.error(message: "project save error")
            return false
        }
        log.info(message: "project save success : \(project)")
        return true
    }
    
    //
    func edit(id:Int, name:String, unit:String, cycle:Int, goals:[[String:Double]], missions:[[String:Double]], startDate:Double) -> Bool {
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
    
    func delete(project:Project) {
        try! realm.write {
            log.debug(message: "\(String(describing: project)) 삭제")
            realm.delete(project)
        }
    }
    
    func delete(id:Int) {
        let project = findOne(id: id)!
        try! realm.write {
            log.debug(message: "\(String(describing: project)) 삭제")
            realm.delete(project)
        }
    }
    
    func deleteHistory(mission:Mission, index:Int) {
        mission.getMissionHistories().remove(objectAtIndex: index)
    }
    
    /* project director */
    
    func achievementRate(project:Project) -> Double {
        var achievementRate = (project.getSuccessMissionTotal() / project.getGoalTotal()) * 100.0
        return achievementRate.roundToPlaces(places: 2)
    }
    
    func expectHitBonJeonDay(project:Project) -> TimeInterval {
        let day = Int(round(project.getRemainGoal() / project.getMissionTotal()) * Double(project.cycle))
        return TimeInterval(project.startDate).plusDay(dayAmount: day)
    }
    
    func addMissionHistory(mission:Mission, history:History) {
        do {
            try realm.write {
                if 0 < history.successCount {
                    mission.successCount += history.successCount
                }
                mission.appendMissionHistory(history: history)
            }
        }
        catch {
            log.error(message: "project save error")
        }
        log.info(message: "mission history save : \(history)")
    }
    
}

extension Double {
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}

enum ContentsSaveError : Error {
    case contentsIsEmpty
}
