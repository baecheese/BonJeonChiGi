//
//  WriteTableViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 29..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class WriteTableViewController: UITableViewController, WriteSectionDelegate, WriteTableViewCellDelegate, PickerCellDelegate, DatePickerCellDelegate {
    
    private let log = Logger(logPlace: WriteTableViewController.self)
    private let projectRepository = ProjectRepository.sharedInstance
    private let colorManager = ColorManager.sharedInstance
    private var callPickerIndexPath:IndexPath? = nil
    private var selectDate = TimeInterval().now()
    private var selectCycle = 0
    private var selectUnit = "₩"
    private var projectNameSectionCount = 4
    private var goalItemsCount = 1
    private var missionItemsCount = 1
    
    private var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeNavigationItem()  {
        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        backBtn.backgroundColor = .black
        backBtn.setTitle("save", for: .normal)
        backBtn.addTarget(self, action: #selector(WriteTableViewController.save), for: .touchUpInside)
        let item = UIBarButtonItem(customView: backBtn)
        navigationItem.rightBarButtonItem = item
    }
    
    func save() {
        let contents = getContents()
        if false == contents.0 {
            showAlert(message: "contents empty!", haveCancel: false, doneHandler: nil, cancelHandler: nil)
        }
        else {
            let content = (contents.1)!
            let project = creatProject(content: content)
            if true == projectRepository.save(project: project) {
                let main = self.navigationController?.viewControllers.first as! MainTableTableViewController
                main.tableView.reloadData()
                self.navigationController?.popViewController(animated: true)
            }
            else {
                showAlert(message: "save error. try again.", haveCancel: false, doneHandler: nil, cancelHandler: nil)
            }
        }
    }
    
    func creatProject(content:[ProgressKey:Any]) -> Project {
        let project = Project()
        project.name = content[ProgressKey.projectName] as! String
        project.startDate = content[ProgressKey.startDate] as! Double
        project.cycle = content[ProgressKey.cycle] as! Int
        project.unit = content[ProgressKey.unit] as! String
        
        let goalList = content[ProgressKey.goalTotal] as! [[String]]
        let missionList = content[ProgressKey.missionTotal] as! [[String]]
        
        for goalInfo in goalList {
            let goal = Goal()
            goal.name = goalInfo[0]
            goal.value = Double(goalInfo[1])!
            project.appendGoal(goal: goal)
        }
        
        for missionInfo in missionList {
            let mission = Mission()
            mission.name = missionInfo[0]
            mission.value = Double(missionInfo[1])!
            project.appendMission(mission: mission)
        }
        
        
        return project
    }
    
    func getContents() -> (Bool, [ProgressKey:Any]?) {
        var result = [ProgressKey:Any]()
        var goalList = [[String?]]()
        var missionList = [[String?]]()
        let rowCountList = [projectNameSectionCount, goalItemsCount, missionItemsCount]
        for section in 0...getWriteKeys().count-1 {
            for row in 0...rowCountList[section]-1 {
                // project setting
                if 0 == section {
                    if 0 == row {
                        let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as! WriteTableViewCell
                        if true == (cell.name.text?.isEmpty) {
                            return (false, nil)
                        }
                        result[ProgressKey.projectName] = cell.name.text
                    }
                }
                // detail info
                else {
                    let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as! WriteTableViewCell
                    
                    if true == (cell.name.text?.isEmpty) || true == (cell.value.text?.isEmpty) {
                        return (false, nil)
                    }
                    
                    let info = [cell.name.text, cell.value.text]
                    if 1 == section {
                        goalList.append(info)
                    }
                    if 2 == section {
                        missionList.append(info)
                    }
                }
            }
            result[ProgressKey.startDate] = selectDate
            result[ProgressKey.cycle] = selectCycle
            result[ProgressKey.unit] = selectUnit
            result[ProgressKey.goalTotal] = goalList
            result[ProgressKey.missionTotal] = missionList
            
        }
        
        return (true, result)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "temp"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerBounds = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40.0)
        let sectionView = WriteSection(frame: headerBounds, title: getWriteKeys()[section]!, section: section)
        sectionView.delegate = self
        sectionView.backgroundColor = colorManager.writeSection
        if 0 == section {
            sectionView.isHideButton(status: true)
        }
        return sectionView
    }
    
    private func getWriteKeys() -> [String?] {
        let keys = ProgressNames().get
        return [
            keys[ProgressKey.projectName]
            , keys[ProgressKey.goalTotal]
            , keys[ProgressKey.missionTotal]
        ]
    }
    
    func addCell(section: Int) {
        print("\(section) add cell")
        tableView.beginUpdates()
        if 1 == section {
            self.tableView.insertRows(at: [IndexPath.init(row: goalItemsCount, section: section)], with: .automatic)
            goalItemsCount += 1
        }
        if 2 == section {
            self.tableView.insertRows(at: [IndexPath.init(row: missionItemsCount, section: section)], with: .automatic)
            missionItemsCount += 1
        }
        tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 1 == section {
            return goalItemsCount
        }
        if 2 == section {
            return missionItemsCount
        }
        if callPickerIndexPath != nil {
            return projectNameSectionCount + 1
        }
        return projectNameSectionCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if 0 == indexPath.section && 0 != indexPath.row {
            return setProjectNameSectionCell(indexPath: indexPath)
        }
        let writeTableViewCell = Bundle.main.loadNibNamed("WriteTableViewCell", owner: self, options: nil)?.first as! WriteTableViewCell
        if 0 == indexPath.section && 0 == indexPath.row {
            writeTableViewCell.value.alpha = 0.0
        }
        writeTableViewCell.delegate = self
        writeTableViewCell.selectionStyle = .none
        writeTableViewCell.name.text = nil
        writeTableViewCell.value.text = nil
        return writeTableViewCell
    }
    
    func setProjectNameSectionCell(indexPath:IndexPath) -> UITableViewCell {
         if callPickerIndexPath != nil {
            if 1 == callPickerIndexPath?.row && indexPath.row == callPickerIndexPath!.row + 1 {
                let datePickerCell = Bundle.main.loadNibNamed("DateTableViewCell", owner: self, options: nil)?.first as! DateTableViewCell
                datePickerCell.delegate = self
                return datePickerCell
            }
            else {
                let pickerCell = Bundle.main.loadNibNamed("PickerViewTableViewCell", owner: self, options: nil)?.first as! PickerViewTableViewCell
                pickerCell.delegate = self
                pickerCell.set(progressKey: getSelectSheetTitleToCall())
                return pickerCell
            }
        }
        let selectSheetCell = Bundle.main.loadNibNamed("SelectSheetCell", owner: self, options: nil)?.first as! SelectSheetCell
        selectSheetCell.selectionStyle = .none
        setInfoSelectCell(cell: selectSheetCell, indexPath: indexPath)
        return selectSheetCell
    }
    
    private func setInfoSelectCell(cell:SelectSheetCell, indexPath:IndexPath) {
        let names = ProgressNames().get
        if 1 == indexPath.row {
            cell.name.text = names[ProgressKey.startDate]
            cell.value.text = TimeInterval().now().getYYMMDD()
        }
        if 2 == indexPath.row {
            cell.name.text = names[ProgressKey.cycle]
            cell.value.text = ChoiceList().cycle[0]
        }
        if 3 == indexPath.row {
            cell.name.text = names[ProgressKey.unit]
            cell.value.text = ChoiceList().unit[0]
        }
    }
    
    private func getSelectSheetTitleToCall() -> ProgressKey {
        if 1 == callPickerIndexPath?.row {
            return ProgressKey.startDate
        }
        if 2 == callPickerIndexPath?.row {
            return ProgressKey.cycle
        }
        if 3 == callPickerIndexPath?.row {
            return ProgressKey.unit
        }
        return ProgressKey.error
    }
    
    private func getSelectSheetTitle(row:Int) -> ProgressKey {
        if 1 == row {
            return ProgressKey.startDate
        }
        if 2 == row {
            return ProgressKey.cycle
        }
        if 3 == row {
            return ProgressKey.unit
        }
        return ProgressKey.error
    }
    
    // date picker
    func changeDatePickerCell(date:TimeInterval) {
        if nil != callPickerIndexPath {
            let cell = tableView.cellForRow(at: callPickerIndexPath!) as! SelectSheetCell
            selectDate = date
            cell.value.text = date.getYYMMDD()
        }
    }
    
    // data picker
    func changePickerCellData(selectRow: Int) {
        if nil != callPickerIndexPath {
            var info = ""
            if 2 == callPickerIndexPath?.row {
                info = ChoiceList().cycle[selectRow]
                selectCycle = ChoiceList().cycleNumber[selectRow]
            }
            if 3 == callPickerIndexPath?.row {
                info = ChoiceList().unit[selectRow]
                selectUnit = info
            }
            let cell = tableView.cellForRow(at: callPickerIndexPath!) as! SelectSheetCell
            cell.value.text = info
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if 0 == indexPath.section && 0 != indexPath.row {
            if callPickerIndexPath != indexPath {
                showPickerView(indexPath: indexPath)
                return;
            }
        }
        if nil != callPickerIndexPath {
            closeBeforePickerView()
        }
    }
    
    func startEditingToTextField() {
        if nil != callPickerIndexPath {
            closeBeforePickerView()
        }
    }
    
    func showPickerView(indexPath:IndexPath) {
        if nil != callPickerIndexPath {
            closeBeforePickerView()
            return;
        }
        let cell = tableView.cellForRow(at: indexPath) as! SelectSheetCell
        cell.name.textColor = .red
        cell.value.textColor = .red
        tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath.init(row: indexPath.row + 1, section: indexPath.section)], with: .automatic)
        callPickerIndexPath = IndexPath(row: indexPath.row, section: indexPath.section)
        tableView.endUpdates()
    }
    
    func closeBeforePickerView() {
        let cell = tableView.cellForRow(at: callPickerIndexPath!) as! SelectSheetCell
        cell.name.textColor = .black
        cell.value.textColor = .black
        
        let pickerIndexPath = IndexPath(row: callPickerIndexPath!.row + 1, section: callPickerIndexPath!.section)
        callPickerIndexPath = nil
        tableView.deleteRows(at: [pickerIndexPath], with: .fade)
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if 0 != indexPath.section {
            log.info(message: "\(indexPath.section) \(indexPath.row)")
            if 1 == indexPath.section {
                goalItemsCount -= 1
            }
            if 2 == indexPath.section {
                missionItemsCount -= 1
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func showAlert(message:String, haveCancel:Bool, doneHandler:((UIAlertAction) -> Swift.Void)?, cancelHandler:((UIAlertAction) -> Swift.Void)?)
    {
        let alertController = UIAlertController(title: "Notice", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default,handler: doneHandler))
        if haveCancel {
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: cancelHandler))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
}
