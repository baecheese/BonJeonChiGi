//
//  Bill.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 27..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import Foundation
import RealmSwift
//
//class Spend: Object {
//    dynamic var spendKey:String = ""
//    dynamic var spendMoney:Int = 0
//    dynamic var hit:Bool = false
//}
//
//class Income: Object {
//    dynamic var incomeKey:String = ""
//    dynamic var incomeMoney:Int = 0
//    dynamic var count = 0
//}

class Bill: Object {
    dynamic var id = 0
    dynamic var name:String = ""
    
//    var spendList = List<Spend>()
//    var incomeList = List<Income>()
//    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
//    
//    func appendSpend(spend:Spend) {
//        self.spendList.append(spend)
//    }
//    
//    func appendIncome(income:Income) {
//        self.incomeList.append(income)
//    }
    
}
