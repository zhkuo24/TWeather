//
//  WeatherNow.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/17.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import Foundation

class WeatherNow: NSObject,NSCoding {

    var condTxt: String = ""
    var tmp: String = ""
    var windDir: String = ""
    var windSc: String = ""
    var qlty: String = ""
    
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        condTxt = aDecoder.decodeObjectForKey("condTxt") as! String
        tmp = aDecoder.decodeObjectForKey("tmp") as! String
        windDir = aDecoder.decodeObjectForKey("windDir") as! String
        windSc = aDecoder.decodeObjectForKey("windSc") as! String
        qlty = aDecoder.decodeObjectForKey("qlty") as! String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(condTxt, forKey: "condTxt")
        aCoder.encodeObject(tmp, forKey: "tmp")
        aCoder.encodeObject(windDir, forKey: "windDir")
        aCoder.encodeObject(windSc, forKey: "windSc")
        aCoder.encodeObject(qlty, forKey: "qlty")
    }
}
