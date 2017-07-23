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
    
    private let log = Logger(logPlace: MainViewController.self)
    private let billRepository = BillRepository.sharedInstance
    var selectProject:Project?
    var missionList:Array<Mission>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        tableview.delegate = self
        tableview.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLayoutSubviews() {
        setProgressGraph()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if .delete == editingStyle {
            // mission delete
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.info(message: "didSelectRowAt : \(indexPath.row)")
        if let mission = missionList?[indexPath.row] {
            let cell = tableView.cellForRow(at: indexPath)
            UIView.animate(withDuration: 1.0, animations: {
                cell?.backgroundColor = .red
                self.pushMissionCount(mission: mission)
            }, completion: nil)
        }
    }
    
    func setProgressGraph() {
        
    }
    
    func pushMissionCount(mission:Mission) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
