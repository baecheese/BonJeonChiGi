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

class WriteTableViewController: UITableViewController {
    
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
        var spendList = [[String:Int]]()
        var incomeList = [[String:Int]]()
        for section in 0...billRepository.getWriteKey().count-1 {
            let indexPath = IndexPath(row: 0, section: section)
            let cell = tableView.cellForRow(at: indexPath) as! WriteCell
            var spend = [String:Int]()
            spend[cell.name.text!] = Int(cell.price.text!)
            if 0 == section {
                print("name : \(cell.name.text), price : \(cell.price.text)")
                spendList.append(spend)
            }
            if 1 == section {
                print("name : \(cell.name.text), price : \(cell.price.text)")
                incomeList.append(spend)
            }
        }
        
        billRepository.saveBill(spends: spendList, incomes: incomeList)
        print("save")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return billRepository.getWriteKey().count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return billRepository.getWriteKey()[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WriteCell", for: indexPath) as! WriteCell
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
