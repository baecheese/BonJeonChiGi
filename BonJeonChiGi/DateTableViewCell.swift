//
//  DateTableViewCell.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 19..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

protocol DatePickerCellDelegate {
    func changeDatePickerCell(date:String)
}

class DateTableViewCell: UITableViewCell, UIPickerViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate:DatePickerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func dateChanged(_ sender:UIDatePicker) {
        delegate?.changeDatePickerCell(date: TimeInterval().getYYMMDD(date: sender.date))
        print(TimeInterval().getYYMMDD(date: sender.date))
    }
    
    
}
