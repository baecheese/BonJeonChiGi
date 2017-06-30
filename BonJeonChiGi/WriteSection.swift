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
    var delegate:WriteSectionDelegate?
    
    var section:Int = 0
    
    init(frame: CGRect, title:String, section:Int) {
        super.init(frame: frame)
        self.section = section
        set(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set(title:String) {
        let width = self.frame.width
        let height = self.frame.height
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: width*0.7, height: height))
        titleLabel.text = title
        titleLabel.backgroundColor = .blue
        self.addSubview(titleLabel)
        
        let addButton = UIButton(frame: CGRect(x: width*0.7, y: 0, width: width*0.3, height: height))
        addButton.setTitle("add", for: .normal)
        addButton.addTarget(self, action: #selector(WriteSection.add), for: UIControlEvents.touchUpInside)
        addButton.backgroundColor = .red
        self.addSubview(addButton)
    }
    
    func add() {
        delegate?.addCell(section: self.section)
    }
    

}
