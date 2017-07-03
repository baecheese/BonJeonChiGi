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
    private let billRepository = BillRepository.sharedInstance
    private var spendItemsCount = 1
    private var incomeItemsCout = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationItem()
        tableView.allowsSelection = false
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
        if true == isEmptyContents() {
            log.error(message: "contents empty")
        }
        else {
            let contents = getContents()
            log.info(message: contents)
//            if true == (billRepository.saveBill(name: contents.0, spends: contents.1, incomes: contents.2)) {
//                log.info(message: "save")
//            }
//            else {
//                log.info(message: "dont save")
//            }
        }
    }
    
    func getContents() -> (String, [[String:Int]], [[String:Int]]) {
        var name = ""
        var spendList = [[String:Int]]()
        var incomeList = [[String:Int]]()
        for section in 0...billRepository.getWriteKey().count-1 {
            let indexPath = getIndexPath(section: section)
            let cell = tableView.cellForRow(at: indexPath) as! WriteCell
            var spend = [String:Int]()
            var income = [String:Int]()
            for row in 0...indexPath.row {
                if 0 == section {
                    name = "\(String(describing: cell.name.text!))"
                }
                if 1 == section {
                    spend[cell.name.text!] = Int(cell.price.text!)
                    spendList.append(spend)
                }
                if 2 == section {
                    income[cell.name.text!] = Int(cell.price.text!)
                    incomeList.append(income)
                }
            }
        }
        return (name, spendList, incomeList)
    }
    
    func isEmptyContents() -> Bool {
        for section in 0...billRepository.getWriteKey().count-1 {
            let indexPath = IndexPath(row: 0, section: section)
            let cell = tableView.cellForRow(at: indexPath) as! WriteCell
            if true == cell.name.text?.isEmpty || true == cell.name.text?.isEmpty {
                return true
            }
        }
        return false
    }
    
    func getIndexPath(section:Int) -> IndexPath {
        if 1 == section {
            return IndexPath(row: spendItemsCount-1, section: 1)
        }
        if 2 == section {
            return IndexPath(row: incomeItemsCout-1, section: 2)
        }
        return IndexPath(row: 0, section: 0)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return billRepository.getWriteKey().count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "temp"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerBounds = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40.0)
        let sectionView = WriteSection(frame: headerBounds, title: billRepository.getWriteKey()[section], section: section)
        sectionView.delegate = self
        sectionView.backgroundColor = .black
        if 0 == section {
            sectionView.isHideButton(status: true)
        }
        return sectionView
    }
    
    func addCell(section: Int) {
        print("\(section) add cell")
        self.tableView.beginUpdates()
        if 1 == section {
            self.tableView.insertRows(at: [IndexPath.init(row: spendItemsCount, section: section)], with: .automatic)
            spendItemsCount += 1
        }
        if 2 == section {
            self.tableView.insertRows(at: [IndexPath.init(row: incomeItemsCout, section: section)], with: .automatic)
            incomeItemsCout += 1
        }
        self.tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 1 == section {
            return spendItemsCount
        }
        if 2 == section {
            return incomeItemsCout
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WriteCell", for: indexPath) as! WriteCell
        if 0 == indexPath.section {
            cell.price.alpha = 0.0
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if 0 != indexPath.section {
            return true
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if 0 != indexPath.section {
            log.info(message: "\(indexPath.section) \(indexPath.row)")
            deleteContentsInCell(indexPath: indexPath)
            if 1 == indexPath.section {
                spendItemsCount -= 1
            }
            if 2 == indexPath.section {
                incomeItemsCout -= 1
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func deleteContentsInCell(indexPath:IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! WriteCell
        cell.name.text = nil
        cell.price.text = nil
    }
    
}
