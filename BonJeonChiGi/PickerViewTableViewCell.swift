//
//  PickerViewTableViewCell.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 19..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class PickerViewTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    private var list = ["?"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func set(progressKey:ProgressKey) {
        // 시작 날짜 처리 --- cheesing
        if progressKey == ProgressKey.unit {
            list = ChoiceList().unit
        }
        if progressKey == ProgressKey.cycle {
            list = ChoiceList().cycle
        }
        pickerView.reloadAllComponents()
    }
    
}
