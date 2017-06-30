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
        cell.textLabel?.text = billRepository.getAll()[indexPath.row].name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainProgress.changeProgressData(id: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        SharedMemoryContext.set(key: contextKey.selectId, setValue: indexPath.row)
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailProgressTableViewController") as! DetailProgressTableViewController
        self.navigationController?.pushViewController(detailVC, animated: true)
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
