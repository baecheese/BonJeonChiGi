//
//  MainResult.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 26..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class MainResult: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    private var billRepository = BillRepository.sharedInstance
    private var totalSpendMoney = UITextView()
    
    func setSpendMoneyTotalLabel(id:Int) {
        let width = self.frame.width * 0.6
        let hight = self.frame.height * 0.5
        let offsetX = self.frame.width/2 - width/2
        let offsetY = self.frame.height/2 - hight/2
        totalSpendMoney.frame = CGRect(x: offsetX, y: offsetY, width: width, height: hight)
        totalSpendMoney.textAlignment = .center
        totalSpendMoney.backgroundColor = .blue
        totalSpendMoney.isEditable = false
        changeProgressData(id: id)
        self.addSubview(totalSpendMoney)
    }
    
    func changeProgressData(id:Int) {
        totalSpendMoney.text = "\(billRepository.findOne(id: id))"
//        totalSpendMoney.text = "총 지출 : \(billRepository.getSpendMoneyTotal(id: id))원 \n 총 수익 : \(billRepository.getIncomeMoneyTotal(id: id)) 수익 리스트 \(billRepository.getIncomeList(id: id))원 \n  달성율 : ... % \n 남은 횟수 : n번"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
