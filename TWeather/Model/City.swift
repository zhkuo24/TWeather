//
//  City.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/17.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import Foundation

class City: NSObject,NSCoding {
    
    var cityCN = ""
    
    override init(){
        super.init()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        cityCN = aDecoder.decodeObjectForKey("CityCN") as! String
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(cityCN, forKey: "CityCN")
    }

}
