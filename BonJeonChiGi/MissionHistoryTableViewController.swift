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
    
    var mission:Mission? = nil
    var missionHistories:[History]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = mission?.name {
            self.navigationController?.title = "\(name)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let histories = missionHistories {
            return histories.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MissionHistoryCell") as! MissionHistoryCell
        if let date = missionHistories?[indexPath.row].date {
            cell.textLabel?.text = "\(TimeInterval(date).getAllTimeInfo())"
        }
        return cell
    }
    
}
