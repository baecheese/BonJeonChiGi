//
//  DetailProgressTableViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 26..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet var name: UILabel!
}

class DetailProgressTableViewController: UITableViewController {
    
    private let log = Logger(logPlace: DetailProgressTableViewController.self)
    private let billRepository = BillRepository.sharedInstance
    private let bill = BillRepository.sharedInstance.findOne(id: SharedMemoryContext.get(key: contextKey.selectId) as! Int)!
    private let progressNames = ProgressNames()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        makeNavigationItem()
    }

    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeNavigationItem()  {
        let edit = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        edit.backgroundColor = .black
        edit.setTitle("edit", for: .normal)
        edit.addTarget(self, action: #selector(DetailProgressTableViewController.edit), for: .touchUpInside)
        let item = UIBarButtonItem(customView: edit)
        navigationItem.rightBarButtonItem = item
    }
    
    func edit() {
        log.info(message: "edit")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return billRepository.getReadKey().count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return billRepository.getReadKey()[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 2 == section {
            return bill.spendList.count
        }
        if 3 == section {
            return bill.incomeList.count
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
        if 0 == indexPath.section {
            cell.name.text = bill.name
        }
        if 1 == indexPath.section {
            cell.name.text = "\(billRepository.getBalanceMoney(bill: bill))"
        }
        if 2 == indexPath.section {
            let spend = bill.spendList[indexPath.row]
            cell.name.text = "* \(spend.spendKey) : \(spend.spendMoney)"
        }
        if 3 == indexPath.section {
            let income = bill.incomeList[indexPath.row]
            cell.name.text = "* \(income.incomeMoney) : \(income.incomeMoney) ⚡️ hit: \(income.count)"
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
