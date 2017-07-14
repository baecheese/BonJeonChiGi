//
//  WriteTableViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 29..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class WriteCell: UITableViewCell {
    @IBOutlet var name: UITextField!
    @IBOutlet var price: UITextField!
}

class WriteTableViewController: UITableViewController, WriteSectionDelegate {
    
    private let log = Logger(logPlace: WriteTableViewController.self)
    private let projectRepository = ProjectRepository.sharedInstance
    private var openPickerIndexPath:IndexPath? = nil
    private var projectNameSectionCount = 3
    private var spendItemsCount = 1
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
//        if true == isEmptyContents() {
//            showAlert(message: "contents empty!", haveCancel: false, doneHandler: nil, cancelHandler: nil)
//        }
//        else {
//            let contents = getContents()
//            log.info(message: contents)
//            if true == (billRepository.saveBill(name: contents.0, spends: contents.1, incomes: contents.2)) {
//                let main = self.navigationController?.viewControllers.first as? MainViewController
//                main?.tableview.reloadData()
//                self.navigationController?.popViewController(animated: true)
//            }
//            else {
//                showAlert(message: "save error. try again.", haveCancel: false, doneHandler: nil, cancelHandler: nil)
//            }
//        }
    }
    
//    func getContents() -> (String, [[String:Int]], [[String:Int]]) {
//        var name = ""
//        var spendList = [[String:Int]]()
//        var incomeList = [[String:Int]]()
//        for section in 0...billRepository.getWriteKey().count-1 {
//            for row in 0...getRowLastIndex(section:section) {
//                var spend = [String:Int]()
//                var income = [String:Int]()
//                let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as! WriteCell
//                if 0 == section {
//                    name = "\(String(describing: cell.name.text!))"
//                }
//                if 1 == section {
//                    spend[cell.name.text!] = Int(cell.price.text!)
//                    spendList.append(spend)
//                }
//                if 2 == section {
//                    income[cell.name.text!] = Int(cell.price.text!)
//                    incomeList.append(income)
//                }
//            }
//        }
//        return (name, spendList, incomeList)
//    }
    
//    func isEmptyContents() -> Bool {
//        for section in 0...billRepository.getWriteKey().count-1 {
//            let indexPath = IndexPath(row: 0, section: section)
//            let cell = tableView.cellForRow(at: indexPath) as! WriteCell
//            if true == cell.name.text?.isEmpty || true == cell.name.text?.isEmpty {
//                return true
//            }
//        }
//        return false
//    }
    
//    func getRowLastIndex(section:Int) -> Int {
//        if 1 == section {
//            return spendItemsCount - 1
//        }
//        if 2 == section {
//            return incomeItemsCout - 1
//        }
//        return 0
//    }

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
        sectionView.backgroundColor = .black
        if 0 == section {
            sectionView.isHideButton(status: true)
        }
        return sectionView
    }
    
    private func getWriteKeys() -> [String?] {
        let keys = ProgressNames().get
        return [
            keys[ProgressKey.projectName]
            , keys[ProgressKey.spendTotal]
            , keys[ProgressKey.missionTotal]
        ]
    }
    
    func addCell(section: Int) {
        print("\(section) add cell")
        tableView.beginUpdates()
        if 1 == section {
            self.tableView.insertRows(at: [IndexPath.init(row: spendItemsCount, section: section)], with: .automatic)
            spendItemsCount += 1
        }
        if 2 == section {
            self.tableView.insertRows(at: [IndexPath.init(row: missionItemsCount, section: section)], with: .automatic)
            missionItemsCount += 1
        }
        tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 1 == section {
            return spendItemsCount
        }
        if 2 == section {
            return missionItemsCount
        }
        return projectNameSectionCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if nil != openPickerIndexPath && openPickerIndexPath == indexPath {
            return 100.0
        }
        return 60.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WriteCell", for: indexPath) as! WriteCell
        setRowInProjectNameSection(cell: cell, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    private func setRowInProjectNameSection(cell: WriteCell, indexPath: IndexPath) {
        if 0 == indexPath.section {
            cell.price.alpha = 0.0
            if 0 != indexPath.row {
                cell.name.alpha = 0.0
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if 0 == indexPath.section {
            if 0 != indexPath.row {
                openPickerIndexPath = indexPath
                tableView.beginUpdates()
                tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
                tableView.endUpdates()
            }
        }
        log.info(message: indexPath)
    
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath
    ) {
        
        if 0 != indexPath.section {
            log.info(message: "\(indexPath.section) \(indexPath.row)")
            deleteContentsInCell(indexPath: indexPath)
            if 1 == indexPath.section {
                spendItemsCount -= 1
            }
            if 2 == indexPath.section {
                missionItemsCount -= 1
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func deleteContentsInCell(indexPath:IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WriteCell
        cell.name.text = nil
        cell.price.text = nil
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
    
    
    ////
    private func getSelectList(kind:ProgressKey) -> [String] {
        let list = ChoiceList()
        if kind == ProgressKey.unit {
            return list.unit
        }
        if kind == ProgressKey.cycle {
            return list.cycle
        }
        return ["저장된 리스트가 없습니다."]
    }
}
