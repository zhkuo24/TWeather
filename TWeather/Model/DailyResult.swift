//
//  DailyResult.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/17.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import Foundation

class DailyResult: NSObject,NSCoding {
    
    var date: String = ""
    var condTxtd: String = ""
    var tmpMax: String = ""
    var tmpMin: String = ""
    var windDir: String = ""
    var windSc: String = ""
    var condTxtn: String = ""
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        date = aDecoder.decodeObjectForKey("date") as! String
        condTxtd = aDecoder.decodeObjectForKey("condTxtd") as! String
        tmpMax = aDecoder.decodeObjectForKey("tmpMax") as! String
        tmpMin = aDecoder.decodeObjectForKey("tmpMin") as! String
        windDir = aDecoder.decodeObjectForKey("windDir") as! String
        windSc = aDecoder.decodeObjectForKey("windSc") as! String
        condTxtn = aDecoder.decodeObjectForKey("condTxtn") as! String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(condTxtd, forKey: "condTxtd")
        aCoder.encodeObject(tmpMax, forKey: "tmpMax")
        aCoder.encodeObject(tmpMin, forKey: "tmpMin")
        aCoder.encodeObject(windDir, forKey: "windDir")
        aCoder.encodeObject(windSc, forKey: "windSc")
        aCoder.encodeObject(windSc, forKey: "condTxtn")
    }

}
