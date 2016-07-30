//
//  WeatherTools.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/13.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit
typealias animationFinshion = (Bool) -> Void

func launchAnimation(currentView: UIView,finishion: animationFinshion){
    var animationDone = false
    let launchView = UIImageView(frame: currentView.bounds)
    launchView.imageWithResolution()
    currentView.transform = CGAffineTransformMakeScale(0.8, 0.8)
    launchView.transform = CGAffineTransformMakeScale(1.25, 1.25)
    currentView.addSubview(launchView)
    //启动图片扩大消失动画
    UIView.animateWithDuration(0.3, delay: 0.9, options: [], animations: {
        launchView.transform = CGAffineTransformMakeScale(2.0, 2.0)
        launchView.alpha = 0.0
    }) { (_) in
        launchView.removeFromSuperview()
    }
    //主视图扩大弹跳动画
    UIView.animateWithDuration(0.3, delay: 1.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: { () -> Void in
        currentView.transform = CGAffineTransformMakeScale(1.0, 1.0)
    }){ (_) in
        animationDone = true
        finishion(animationDone)
    }
}




func verticalStrHeight(number:Int, fontSize: CGFloat) -> CGSize {
    var str:String = ""
    for _ in 0..<number {
        str += "张\n"
    }
    let nsStrTmp = str as NSString
    let nsStr = nsStrTmp.substringToIndex(nsStrTmp.length - 1)
    return nsStr.sizeWithAttributes([NSFontAttributeName: UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)!])
}

func numberToChinese(number:Int) -> String {
    let numbers = Array(String(number).characters)
    var finalString = ""
    for singleNumber in numbers {
        let string = singleNumberToChinese(singleNumber)
        finalString = "\(finalString)\(string)"
    }
    return finalString
}

func numberToChineseWithUnit(number:Int) -> String {
    let numbers = Array(String(number).characters)
    var units = unitParser(numbers.count)
    var finalString = ""
    
    for (index, singleNumber) in numbers.enumerate() {
        let string = singleNumberToChinese(singleNumber)
        if (!(string == "零" && (index+1) == numbers.count)){
            finalString = "\(finalString)\(string)\(units[index])"
        }
    }
    
    return finalString
}

func unitParser(unit:Int) -> [String] {
    
    var units = Array(["万","千","百","十",""].reverse())
    let parsedUnits = units[0..<(unit)].reverse()
    let slicedUnits: ArraySlice<String> = ArraySlice(parsedUnits)
    let final: [String] = Array(slicedUnits)
    return final
}



func singleNumberToChinese(number:Character) -> String {
    switch number {
    case "0":
        return "零"
    case "1":
        return "一"
    case "2":
        return "二"
    case "3":
        return "三"
    case "4":
        return "四"
    case "5":
        return "五"
    case "6":
        return "六"
    case "7":
        return "七"
    case "8":
        return "八"
    case "9":
        return "九"
    default:
        return ""
    }
}