//
//  MainTableTableViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 13..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var achievementRate: UILabel!
}

class MainTableTableViewController: UITableViewController {
    
    let log = Logger(logPlace: MainTableTableViewController.self)
    let projectRepository = ProjectRepository.sharedInstance
    let projectAll = ProjectRepository.sharedInstance.findAll()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #warning Incomplete implementation, return the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectAll.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        let project = projectAll[indexPath.row]
        cell.selectionStyle = .none
        cell.projectName.text = project.name
        cell.startDate.text = "시작일 \(project.startDate.getYYMMDD())"
        cell.achievementRate.text = "달성율 \(projectRepository.achievementRate(project: project))"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            projectRepository.delete(project: projectAll[indexPath.row])
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let readPage = storyboard?.instantiateViewController(withIdentifier: "ReadProjectViewController") as! ReadProjectViewController
        let project = projectAll[indexPath.row]
        readPage.selectProject = project
        readPage.missionList = Array(project.getMissionList())
        self.navigationController?.pushViewController(readPage, animated: true)
    }
    
    
    
}
