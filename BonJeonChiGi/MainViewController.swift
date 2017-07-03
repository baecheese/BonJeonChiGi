
//
//  MainViewController.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 5. 20..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableview: UITableView!
    @IBOutlet var progressBack: UIView!

    private let log = Logger(logPlace: MainViewController.self)
    var mainProgress = MainResult()
    private let billRepository = BillRepository.sharedInstance
    private let allBill = BillRepository.sharedInstance.getAll()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        tableview.delegate = self
        tableview.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLayoutSubviews() {
        setMainProgress()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billRepository.getAll().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let bill = allBill[indexPath.row]
        cell.textLabel?.text = bill.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainProgress.changeProgressData(id: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        SharedMemoryContext.set(key: contextKey.selectId, setValue: allBill[indexPath.row].id)
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailProgressTableViewController") as! DetailProgressTableViewController
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if .delete == editingStyle {
            let bill = billRepository.getAll()[indexPath.row]
            billRepository.delete(bill: bill)
            tableView.reloadData()
        }
    }
    
    func setMainProgress() {
        mainProgress = MainResult(frame: progressBack.bounds)
        mainProgress.setSpendMoneyTotalLabel(id: 0)
        progressBack.addSubview(mainProgress)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
