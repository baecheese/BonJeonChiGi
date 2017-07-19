//
//  DateTableViewCell.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 19..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell, UIPickerViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func dateChanged(_ sender:UIDatePicker) {
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        print(dateFormatter.string(from: sender.date))
        
    }
    
    
}
