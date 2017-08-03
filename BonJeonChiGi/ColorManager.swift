//
//  ColorManager.swift
//  BonJeonChiGi
//
//  Created by 배지영 on 2017. 8. 2..
//  Copyright © 2017년 baecheese. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
}

class ColorManager: NSObject {
    
    static let sharedInstance:ColorManager = ColorManager()
    
    private override init() {
        super.init()
    }
    
    let historyAction = UIColor(rgb: 0x1695A3)
    let writeSection = UIColor(rgb: 0xACF0F2)
    let cellAddButton = UIColor(rgb: 0x1695A3)
    
    func getAchievementRateColor(achievementRate:Double) -> UIColor {
        if 100.0 <= achievementRate {
            return UIColor(rgb: 0x375d81)
        }
        else if 90.0 <= achievementRate {
            return UIColor(rgb: 0xff5572)
        }
        return UIColor(rgb: 0xf3f0d6)
    }
    
    
    func getMissionClearColor(history:History) -> UIColor {
        if 0 < history.successCount {
            return .blue
        }
        return .red
    }
    
    func missionCellColor(isSelect:Bool) -> UIColor {
        if true == isSelect {
            return .red
        }
        return .white
    }
    
    
}

