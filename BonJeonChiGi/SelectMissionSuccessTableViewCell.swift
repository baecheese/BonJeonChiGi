//
//  SelectMissionSuccessTableViewCell.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 8. 6..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

protocol SelectMissionSuccessTableViewCellDelegate {
    func click(sender:UIButton)
}

class SelectMissionSuccessTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var yes: UIButton!
    @IBOutlet private weak var no: UIButton!
    
    var delegate:SelectMissionSuccessTableViewCellDelegate?
    
    let colorManager = ColorManager.sharedInstance
    
    var selectedButton:UIButton?
    
    @IBAction func selectButton(_ sender: UIButton) {
        self.delegate?.click(sender: sender)
        if let seleted = selectedButton {
            if seleted != sender {
                seleted.isSelected = !seleted.isSelected
            }
        }
        selectedButton = sender
        sender.isSelected = !sender.isSelected
    }
    
    private func setButtonColor() {
        yes.setTitleColor(.black, for: .normal)
        no.setTitleColor(.black, for: .normal)
        yes.setTitleColor(.red, for: .selected)
        no.setTitleColor(.red, for: .selected)
    }
    
    private func setButtonTitle() {
        yes.setTitle("Yes", for: .selected)
        no.setTitle("No", for: .selected)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setButtonColor()
        setButtonTitle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
