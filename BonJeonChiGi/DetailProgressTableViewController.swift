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
            cell.name.text = "* \(income.incomeKey) : \(income.incomeMoney) ⚡️ count: \(income.count)"
            makeHitButton(cell: cell, row: indexPath.row)
        }
        return cell
    }
    
    func makeHitButton(cell:DetailCell, row:Int) {
        let width:CGFloat = 50.0
        let height:CGFloat = cell.contentView.frame.height
        let offsetX:CGFloat = cell.contentView.frame.width - width
        
        let decrease = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let increase = UIButton(frame: CGRect(x: offsetX, y: 0, width: width, height: height))
        
        decrease.setTitle("-", for: .normal)
        increase.setTitle("+", for: .normal)
        
        decrease.backgroundColor = .blue
        increase.backgroundColor = .red
        
        decrease.tag = row
        increase.tag = row
        
        decrease.addTarget(self, action: #selector(decreaseCount), for: UIControlEvents.touchUpInside)
        increase.addTarget(self, action: #selector(increaseCount), for: UIControlEvents.touchUpInside)
        
        cell.contentView.addSubview(decrease)
        cell.contentView.addSubview(increase)
    }
    
    func decreaseCount(sender:UIButton) {
        if billRepository.editIncomeCount(id: SharedMemoryContext.get(key: contextKey.selectId) as! Int, index: sender.tag, increase: false) {
            allTableViewReload()
        }
    }
    
    func increaseCount(sender:UIButton) {
        if billRepository.editIncomeCount(id: SharedMemoryContext.get(key: contextKey.selectId) as! Int, index: sender.tag, increase: true) {
            allTableViewReload()
        }
    }
    
    func allTableViewReload() {
        tableView.reloadData()
        let main = self.navigationController?.viewControllers.first as? MainViewController
        main?.tableview.reloadData()
    }
    
}
