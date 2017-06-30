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
        let bill = Bill()
        var latestId = 0
        do {
            try realm.write {
                if (false == realm.isEmpty) {
                    latestId = (realm.objects(Bill.self).max(ofProperty: "id") as Int?)!
                    latestId += 1
                    bill.id = latestId
                }
                else if (true == realm.isEmpty) {
                    bill.id = latestId
                }
                
                for oneSpend in spends {
                    let name = oneSpend.keys.first!
                    let money = oneSpend.values.first!
                    let spend = Spend()
                    spend.spendKey = name
                    spend.spendMoney = money
                    bill.appendSpend(spend: spend)
                }
                
                for oneIncome in incomes {
                    let name = oneIncome.keys.first!
                    let money = oneIncome.values.first!
                    let income = Income()
                    income.incomeKey = name
                    income.incomeMoney = money
                    bill.appendIncome(income: income)
                }
                realm.add(bill)
            }
        }
        catch ContentsSaveError.contentsIsEmpty {
            log.warn(message: "contentsIsEmpty")
            return false
        }
        catch {
            log.error(message: "error")
            return false
        }
        log.info(message: "Bill : \(bill)")
        return true
    }
    
//    
//    func getIncomeKeyList(id:Int) -> [String]? {
//        let bill = findOne(id: id)
//        return bill?.incomeCount
//    }
//    
//    func getSpendList(id:Int) -> [[String:Int]]? {
//        let bill = findOne(id: id)
//        return bill?.spendList
//    }
//    
//    func getSpendMoneyTotal(id:Int) -> Int {
//        let spendList = getSpendList(id: id)
//        var total = 0
//        if false == spendList?.isEmpty {
//            for aSpend in spendList! {
//                total += aSpend.values.first!
//            }
//        }
//        return total
//    }
//    
//    func getIncomeMoneyTotal(id:Int) -> Int {
//        let incomeList = getIncomeList(id: id)
//        var total = 0
//        if false == incomeList?.isEmpty {
//            for aIncome in incomeList! {
//                total += aIncome.values.first!
//            }
//        }
//        return total
//    }
    
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
