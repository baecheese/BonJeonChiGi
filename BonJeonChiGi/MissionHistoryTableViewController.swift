//
//  MissionHistoryTableViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 25..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class MissionHistoryCell: UITableViewCell {
    
}

class MissionHistoryTableViewController: UITableViewController {

    let log = Logger(logPlace: MissionHistoryTableViewController.self)
    
    let projectRepository = ProjectRepository.sharedInstance
    var missionHistorys:[History]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let historys = missionHistorys {
            return historys.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MissionHistoryCell") as! MissionHistoryCell
        if let date = missionHistorys?[indexPath.row].dateList {
            cell.textLabel?.text = "\(TimeInterval(date).getYYMMDD())"
        }
        return cell
    }
    
}
