//
//  WriteSection.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 6. 30..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

protocol WriteSectionDelegate {
    func addCell(section:Int)
}

class WriteSection: UIView {
    
    private let log = Logger(logPlace: WriteSection.self)
    private var section:Int = 0
    private var addButton = UIButton()
    private let colorManager = ColorManager.sharedInstance
    var delegate:WriteSectionDelegate?
    
    init(frame: CGRect, title:String, section:Int) {
        super.init(frame: frame)
        self.section = section
        set(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set(title:String) {
        let offsetX:CGFloat = 20.0
        let width = self.frame.width - offsetX
        let height = self.frame.height
        let titleLabel = UILabel(frame: CGRect(x: offsetX, y: 0, width: width*0.7, height: height))
        titleLabel.text = title
        self.addSubview(titleLabel)
        
        addButton = UIButton(frame: CGRect(x: titleLabel.frame.width, y: 0, width: width*0.3, height: height))
        addButton.setTitle("add", for: .normal)
        addButton.addTarget(self, action: #selector(WriteSection.add), for: UIControlEvents.touchUpInside)
        addButton.backgroundColor = colorManager.cellAddButton
        self.addSubview(addButton)
    }
    
    func add() {
        delegate?.addCell(section: self.section)
    }
    
    func isHideButton(status:Bool) {
        if true == status {
            self.addButton.alpha = 0.0
        }
    }
    

}
