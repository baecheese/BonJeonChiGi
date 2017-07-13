//
//  MainResult.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 26..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class MainResult: UIView {
    
    private let log = Logger(logPlace: MainResult.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .red
    }
    
    private var billRepository = BillRepository.sharedInstance
    private var totalSpendMoney = UITextView()
    
    func setSpendMoneyTotalLabel(id:Int) {
        let width = self.frame.width * 0.6
        let hight = self.frame.height * 0.25
        let offsetX = self.frame.width/2 - width/2
        let offsetY = self.frame.height/2 - hight/2
        totalSpendMoney.frame = CGRect(x: offsetX, y: offsetY, width: width, height: hight)
        totalSpendMoney.textAlignment = NSTextAlignment.center
        totalSpendMoney.font = UIFont.boldSystemFont(ofSize: 20.0)
//        totalSpendMoney.backgroundColor = .blue
        
        totalSpendMoney.isEditable = false
        changeProgressData(id: id)
        self.addSubview(totalSpendMoney)
    }
    
    func changeProgressData(id:Int) {
        let bill = billRepository.findOne(id: id)
        if nil != bill {
            let balanceMoney = billRepository.getBalanceMoney(bill: bill!)
            totalSpendMoney.text = mainMessage(money: balanceMoney)
        }
        else {
            totalSpendMoney.text = "empty"
        }
    }
    
    func mainMessage(money:Int) -> String {
        if (0 < money) {
            return "본전을 치기 까지 \n\(money)원이 남았습니다."
        }
        return "이미 본전 치셨군요? \n \(money)원 이득 입니다."
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
