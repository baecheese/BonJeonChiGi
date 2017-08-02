//
//  MissionHistoryTableViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 25..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class MissionHistoryCell: UITableViewCell {
    @IBOutlet weak var isSuccess: UIView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var successValue: UILabel!
    @IBOutlet weak var comment: UILabel!
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MissionHistoryCell") as! MissionHistoryCell
        cell.selectionStyle = .none
        if let history = missionHistories?[indexPath.row] {
            cell.date.text = "\(TimeInterval(history.date).getAllTimeInfo())"
            cell.isSuccess.backgroundColor = getMissionClearColor(history: history)
            cell.comment.text = getHistroyComment(history: history)
            cell.successValue.text = String((mission?.value)! * Double(history.successCount))
        }
        
        return cell
    }
    
    private func getMissionClearColor(history:History) -> UIColor {
        if 0 < history.successCount {
            return .blue
        }
        return .red
    }
    
    private func getHistroyComment(history:History) -> String {
        if let comment = history.comment {
            return comment
        }
        return Message().noComment
    }
    
}
