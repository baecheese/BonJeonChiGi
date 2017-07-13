//
//  BillRepository.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 27..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit
import RealmSwift

struct ProgressNames {
    // 이후에 gobal 언어 처리 cheeseing
    let get = [ProgressKey.projectName:"프로젝트명", ProgressKey.spendMoneyTotal:"총 지출", ProgressKey.incomeMoneyTotal:"총 수익", ProgressKey.remainingMoney: "남은 돈"]
}

class BillRepository: NSObject {
    
    private let log = Logger(logPlace: BillRepository.self)
    
    private override init() {
        super.init()
    }
    
    static let sharedInstance:BillRepository = BillRepository()
    private var realm = try! Realm()

    func getAll() -> Results<Bill> {
        let bills:Results<Bill> = realm.objects(Bill.self)
        return bills
    }
    
    func findOne(id:Int) -> Bill? {
        let selectedBill = realm.objects(Bill.self).filter("id = \(id)")
        if (selectedBill.isEmpty) {
            return nil
        }
        return selectedBill[0]
    }
    
    func saveBill(name:String, spends:[[String:Int]], incomes:[[String:Int]]) -> Bool {
//        let bill = Bill()
//        var latestId = 0
//        do {
//            try realm.write {
//                if (false == realm.isEmpty) {
//                    latestId = (realm.objects(Bill.self).max(ofProperty: "id") as Int?)!
//                    latestId += 1
//                    bill.id = latestId
//                }
//                else if (true == realm.isEmpty) {
//                    bill.id = latestId
//                }
//                
//                bill.name = name
//                
//                for oneSpend in spends {
//                    let spendName = oneSpend.keys.first!
//                    let money = oneSpend.values.first!
//                    let spend = Spend()
//                    spend.spendKey = spendName
//                    spend.spendMoney = money
//                    bill.appendSpend(spend: spend)
//                }
//                
//                for oneIncome in incomes {
//                    let incomeName = oneIncome.keys.first!
//                    let money = oneIncome.values.first!
//                    let income = Income()
//                    income.incomeKey = incomeName
//                    income.incomeMoney = money
//                    bill.appendIncome(income: income)
//                }
//                realm.add(bill)
//            }
//        }
//        catch ContentsSaveError.contentsIsEmpty {
//            log.warn(message: "contentsIsEmpty")
//            return false
//        }
//        catch {
//            log.error(message: "error")
//            return false
//        }
//        log.info(message: "Bill : \(bill)")
        return true
    }
    
    //
    func edit(id:Int, name:String, spends:[[String:Int]], incomes:[[String:Int]]) -> Bool {
        let bill = findOne(id: id)
        do {
            try realm.write {

            }
        }
        catch {
            log.error(message: "realm error on")
            return false
        }
        return true
    }
    
    func editIncomeCount(id:Int, index:Int, increase:Bool) -> Bool {
//        let bill = findOne(id: id)!
//        do {
//            try realm.write {
//                if true == increase {
//                    bill.incomeList[index].count += 1
//                }
//                if false == increase && 0 < bill.incomeList[index].count {
//                    bill.incomeList[index].count -= 1
//                }
//            }
//        }
//        catch {
//            log.error(message: "realm error on")
//            return false
//        }
        return true
    }
    
    func delete(bill:Bill) {
        try! realm.write {
            log.debug(message: "\(String(describing: bill)) 삭제")
            realm.delete(bill)
        }
    }
    
    func delete(id:Int) {
//        let bill = findOne(id: id)!
//        try! realm.write {
//            log.debug(message: "\(String(describing: bill)) 삭제")
//            realm.delete(bill)
//        }
    }
    
    func getBalanceMoney(bill:Bill) -> Int {
        var totalSpend = 0
        var hitTotalIncome = 0
        
//        for spend in bill.spendList {
//            totalSpend += spend.spendMoney
//        }
//        
//        for income in bill.incomeList {
//            hitTotalIncome += income.count * income.incomeMoney
//        }
//        
        return totalSpend - hitTotalIncome
    }
    
    func getWriteKey() -> [String] {
        let names = ProgressNames().get
        let keys = [ProgressKey.projectName, ProgressKey.spendMoneyTotal, ProgressKey.incomeMoneyTotal]
        var writeList = [String]()
        for key in keys {
            writeList.append(names[key]!)
        }
        return writeList
    }
    
    func getReadKey() -> [String] {
        let names = ProgressNames().get
        let keys = [ProgressKey.projectName, ProgressKey.remainingMoney, ProgressKey.spendMoneyTotal, ProgressKey.incomeMoneyTotal]
        var readList = [String]()
        for key in keys {
            readList.append(names[key]!)
        }
        return readList
    }
}

enum ProgressKey {
    case projectName
    case spendMoneyTotal
    case incomeMoneyTotal
    case remainingMoney
}

enum ContentsSaveError : Error {
    case contentsIsEmpty
}
