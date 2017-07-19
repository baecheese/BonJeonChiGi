//
//  WriteTableViewCell.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 7. 18..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

protocol WriteTableViewCellDelegate {
    func startEditingToTextField()
}

class WriteTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet var name: UITextField!
    @IBOutlet var value: UITextField!

    var delegate:WriteTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.delegate = self
        value.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.startEditingToTextField()
        return true
    }
    
}
