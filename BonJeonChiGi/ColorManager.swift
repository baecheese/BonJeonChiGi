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
    let navigation = UIColor(rgb: 0x334D5C)
    
    func getAchievementRateColor(achievementRate:Double) -> UIColor {
        if 100.0 <= achievementRate {
            return UIColor(rgb: 0x45B29D)
        }
        else if 90.0 <= achievementRate {
            return UIColor(rgb: 0xDF5A49)
        }
        return UIColor(rgb: 0xEFC94C)
    }
    
    func getAchievementRateColorInCell(achievementRate:Double) -> UIColor {
        return getAchievementRateColor(achievementRate: achievementRate).withAlphaComponent(0.15)
    }
    
    
    func getMissionClearColor(history:History) -> UIColor {
        if 0 < history.successCount {
            return .blue
        }
        return .red
    }
    
    func missionCellColor(isSelect:Bool) -> UIColor {
        if true == isSelect {
            return UIColor(rgb: 0xBEEB9F)
        }
        return .white
    }
    
    
}

