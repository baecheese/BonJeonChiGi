//
//  MainTableTableViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 13..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    @IBOutlet weak var achievementRateColor: UIView!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var achievementRate: UILabel!
}

class MainTableTableViewController: UITableViewController {
    
    let log = Logger(logPlace: MainTableTableViewController.self)
    let projectRepository = ProjectRepository.sharedInstance
    let projectAll = ProjectRepository.sharedInstance.findAll()
    private let colorManager = ColorManager.sharedInstance
    private let fontManager = FontManager()
    
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        let project = projectAll[indexPath.row]
        cell.selectionStyle = .none
        cell.projectName.font = UIFont(name: fontManager.mainFontName, size: 25.0)
        cell.projectName.text = project.name
        cell.startDate.text = "시작일 \(project.startDate.getYYMMDD())"
        let achievementRate = projectRepository.achievementRate(project: project)
        cell.achievementRate.text = "달성율 \(achievementRate)"
        cell.achievementRateColor.backgroundColor = colorManager.getAchievementRateColor(achievementRate: achievementRate)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            projectRepository.delete(project: projectAll[indexPath.row])
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showClickMainCellAnimation(indexPath: indexPath) { (Bool) in
            self.moveReadPage(indexPath: indexPath)
        }
    }
    
    func showClickMainCellAnimation(indexPath:IndexPath, completion:((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.75, animations: { () -> Void in UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
                let cell = self.tableView.cellForRow(at: indexPath) as! MainCell
                UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: cell.achievementRateColor, cache: false)
        }, completion: completion)
    }
    
    func moveReadPage(indexPath:IndexPath) {
        let readPage = self.storyboard?.instantiateViewController(withIdentifier: "ReadProjectViewController") as! ReadProjectViewController
        let project = self.projectAll[indexPath.row]
        readPage.selectProject = project
        readPage.missionList = Array(project.getMissionList())
        self.navigationController?.pushViewController(readPage, animated: true)
    }
    
}
