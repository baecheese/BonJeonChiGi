//
//  TextFiledTableViewCell.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 8. 7..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

class TextFiledTableViewCell: UITableViewCell {

    @IBOutlet weak var textFiled: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
