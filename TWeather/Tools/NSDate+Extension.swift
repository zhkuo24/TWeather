//
//  NSDate+Extension.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/17.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

//古代时间	现代时间
//子时	23点 - 01点
//丑时	01点 - 03点
//寅时	03点 - 05点
//卯时	05点 - 07点
//辰时	07点 - 09点
//巳时	09点 - 11点
//午时	11点 - 13点
//未时	13点 - 15点
//申时	15点 - 17点
//酉时	17点 - 19点
//戌时	19点 - 21点
//亥时	21点 - 23点

import UIKit

extension NSDate {
    
    class func date2ancientTime()->String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute], fromDate: date)
        let dateNow: CGFloat = CGFloat(components.hour) + (0.01 * CGFloat(components.minute))
        var ancientTime:String = ""
        switch dateNow {
        case 1.0...2.59:
            ancientTime = "丑时"
        case 3.0...4.59:
            ancientTime = "寅时"
        case 5.0...6.59:
            ancientTime = "卯时"
        case 7.0...8.59:
            ancientTime = "辰时"
        case 9.0...10.59:
            ancientTime = "巳时"
        case 11.0...12.59:
            ancientTime = "午时"
        case 13.0...14.59:
            ancientTime = "未时"
        case 15.0...16.59:
            ancientTime = "申时"
        case 17.0...18.59:
            ancientTime = "酉时"
        case 19.0...20.59:
            ancientTime = "戌时"
        case 21.0...22.59:
            ancientTime = "亥时"
        case 23.0...23.59:
            ancientTime = "子时"
        case 0...0.59:
            ancientTime = "子时"
        default:
            ancientTime = "子时"
            break
        }
        
        
        return ancientTime
    }
    
    class func SeasonNow() -> String {
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Month], fromDate: date)
        let dateMonth = components.month
        var season:String = ""
        switch dateMonth {
        case 3...5:
            season = "春"
        case 6...8:
            season = "夏"
        case 9...11:
            season = "秋"
        case 12:
            season = "冬"
        case 1...2:
            season = "冬"
        default:
            season = "冬"
        }
        return season
        
    }
    
}
