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
        if true == isEmptyContents() {
            log.error(message: "contents empty")
        }
        else {
            let contents = getContents()
            if true == (billRepository.saveBill(name: contents.0, spends: contents.1, incomes: contents.2)) {
                log.info(message: "save")
            }
            else {
                log.info(message: "dont save")
            }
        }
    }
    
    func getContents() -> (String, [[String:Int]], [[String:Int]]) {
        var name = ""
        var spendList = [[String:Int]]()
        var incomeList = [[String:Int]]()
        for section in 0...billRepository.getWriteKey().count-1 {
            let indexPath = IndexPath(row: 0, section: section)
            let cell = tableView.cellForRow(at: indexPath) as! WriteCell
            var spend = [String:Int]()
            var income = [String:Int]()
            if 0 == section {
                name = "\(String(describing: cell.name.text))"
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        return sectionView
    }

    func addCell(section: Int) {
        print("\(section) add cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WriteCell", for: indexPath) as! WriteCell
        if 0 == indexPath.section {
            cell.price.alpha = 0.0
        }
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
