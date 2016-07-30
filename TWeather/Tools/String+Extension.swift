//
//  String+Extension.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/15.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import Foundation
extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex)
            
            return self[Range(startIndex..<endIndex)]
        }
    }
}
