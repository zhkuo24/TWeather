//
//  WeatherResult.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/17.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import Foundation

class WeatherResult {
    
    var weatherNow: WeatherNow = WeatherNow()
    var forecasts: [DailyResult] = [DailyResult]()
    var weatherNowShow: [String] = [String]()
    var weatherToday: String = ""
    var weatherPoem: [String] = [String]()
    var weatherForecasts: [[String]] = [[String]]()
    var weatherDate: [String] = [String]()
    var location: String = ""
    var time: String = ""
    var city: String = ""
    var ServiceStatus = ""

}
