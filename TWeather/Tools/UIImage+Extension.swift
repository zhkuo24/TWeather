//
//  UIImage+Extension.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/21.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit

extension UIImageView {
    func imageWithResolution(){
        let screenheight = UIScreen.mainScreen().bounds.size.height
        let scale = UIScreen.mainScreen().scale
        let heightRes = screenheight * scale
        switch heightRes{
        case 1136.0:
            self.image = UIImage(named: "iPhoneSE")
        default:
            self.image = UIImage(named: "iPhone")
        }
    }
}
