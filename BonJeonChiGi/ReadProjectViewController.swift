//
//  ReadProjectViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 21..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class ReadProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableview: UITableView!
    
    private let log = Logger(logPlace: MainViewController.self)
    private let billRepository = BillRepository.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableview.delegate = self
        tableview.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLayoutSubviews() {
        setProgressGraph()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        //        let bill = allBill[indexPath.row]
        //        cell.textLabel?.text = bill.name
        //        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if .delete == editingStyle {
            //            let bill = billRepository.getAll()[indexPath.row]
            //            billRepository.delete(bill: bill)
            //            tableView.reloadData()
        }
    }
    
    func setProgressGraph() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
