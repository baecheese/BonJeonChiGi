//
//  ReadProjectViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 21..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class ReadPageMissionCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
}

class ReadProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableview: UITableView!
    private let colorManager = ColorManager.sharedInstance
    private let log = Logger(logPlace: ReadProjectViewController.self)
    private let projectRepositroy = ProjectRepository.sharedInstance
    var selectProject:Project?
    var missionList:Array<Mission>?
    
    @IBOutlet weak var notice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableview.delegate = self
        tableview.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLayoutSubviews() {
        setProgressNotice()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let unit = selectProject?.unit {
            return "mission (\(unit))"
        }
        return "mission"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let missionCount = missionList?.count {
            return missionCount
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadPageMissionCell") as! ReadPageMissionCell
        cell.selectionStyle = .none
        if let mission = missionList?[indexPath.row] {
            cell.name.text = mission.name
            cell.value.text = String(mission.value)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let historyAction = UITableViewRowAction(style: .normal, title: "history") { (rowAction, indexPath) in
            let missionHistroyTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "MissionHistoryTableViewController") as! MissionHistoryTableViewController
            if let mission = self.missionList?[indexPath.row] {
                missionHistroyTableViewController.mission = mission
                missionHistroyTableViewController.missionHistories = Array(mission.getMissionHistories())
            }
            self.navigationController?.pushViewController(missionHistroyTableViewController, animated: true)
        }
        historyAction.backgroundColor = colorManager.historyAction
        return [historyAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.info(message: "didSelectRowAt : \(indexPath.row)")
        
        let cell = tableView.cellForRow(at: indexPath) as! ReadPageMissionCell
        missionCellSelectAnimation(cell: cell, select: true, completion: nil)
        self.showActionSheet(indexPath: indexPath)
    }
    
    func setProgressNotice() {
        if let project = selectProject {
            let graph = TotalGraphView(frame: notice.frame)
            notice.addSubview(graph)
//            let names = ProgressNames()
//            log.info(message: project.startDate.getYYMMDD())
//            notice.text = "\(names.get[ProgressKey.expectedBonJeonDay]!):\(getExpectHitBonJeonDay(project: project)) \n\(names.get[ProgressKey.goalTotal]!):\(project.getGoalTotal()) \n\(names.get[ProgressKey.missionSuccessTotal]!):\(project.getSuccessMissionTotal()) \n \(names.get[ProgressKey.achievementRate]!):\(projectRepositroy.achievementRate(project: project))%"
        }
    }
    
    private func getExpectHitBonJeonDay(project:Project) -> String {
        if 0 == projectRepositroy.expectHitBonJeonDay(project: project) {
            return Message().haveNotCycle
        }
        return projectRepositroy.expectHitBonJeonDay(project: project).getYYMMDD()
    }
    
    func pushMissionHistory(mission:Mission, isSuccess:Bool) {
        let history = History()
        history.date = TimeInterval().now()
        if true == isSuccess {
            history.successCount += 1
        }
        projectRepositroy.addMissionHistory(mission: mission, history: history)
        log.info(message: selectProject!)
        
        let main = self.navigationController?.viewControllers.first as! MainTableTableViewController
        main.tableView.reloadData()
    }
    
    func showActionSheet(indexPath:IndexPath) {
        if let mission = missionList?[indexPath.row] {
            
            log.info(message: "push mission \(mission.name)")
            let message = Message()
            let cell = self.tableview.cellForRow(at: indexPath) as! ReadPageMissionCell
            let optionMenu = UIAlertController(title: nil, message: message.isMissionCount, preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: message.yes, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.log.info(message: "push mission yes")
                self.pushMissionHistory(mission: mission, isSuccess: true)
                self.setProgressNotice()
                self.missionCellSelectAnimation(cell: cell, select: false, completion: nil)
            })
            let no = UIAlertAction(title: message.no, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.log.info(message: "push mission no")
                self.pushMissionHistory(mission: mission, isSuccess: false)
                self.missionCellSelectAnimation(cell: cell, select: false, completion: nil)
            })
            let more = UIAlertAction(title: message.more, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.missionCellSelectAnimation(cell: cell, select: false, completion: { (Bool) in
                    let writeDetailMissionHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "WriteDetailMissionHistoryTableViewController") as! WriteDetailMissionHistoryTableViewController
                    self.navigationController?.pushViewController(writeDetailMissionHistoryVC, animated: true)
                })
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                self.missionCellSelectAnimation(cell: cell, select: false, completion: nil)
            })
            
            optionMenu.addAction(yes)
            optionMenu.addAction(no)
            optionMenu.addAction(more)
            optionMenu.addAction(cancel)
            
            self.present(optionMenu, animated: true, completion: nil)
        }
    }
    
    func missionCellSelectAnimation(cell:ReadPageMissionCell, select:Bool, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.3, animations: {
            cell.backgroundColor = self.colorManager.missionCellColor(isSelect: select)
        }, completion: completion)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
