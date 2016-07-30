//
//  WeatherData.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/17.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit

class WeatherData {
    
    var currentCity = ""
    var cities = [City]()
    var weatherResult = WeatherResult()
    
    init() {
        loadData()
    }
    
    func appendCity(city:City){
        for thisCity in cities{
            if thisCity.cityCN == city.cityCN{
                return
            }
        }
        cities.append(city)
    }
    
    
    private func documentsDirectory() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    private func dataFilePath() -> String{
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("WeatherData.plist")
    }
    
    func saveData(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(currentCity, forKey: "CurrentCity")
        archiver.encodeObject(cities, forKey: "Cities")
        archiver.encodeObject(weatherResult.weatherNowShow, forKey: "weatherNowShow")
        archiver.encodeObject(weatherResult.weatherToday, forKey: "weatherToday")
        archiver.encodeObject(weatherResult.weatherPoem, forKey: "weatherPoem")
        archiver.encodeObject(weatherResult.weatherForecasts, forKey: "weatherForecasts")
        archiver.encodeObject(weatherResult.weatherDate, forKey: "weatherDate")
        archiver.encodeObject(weatherResult.location, forKey: "location")
        archiver.encodeObject(weatherResult.time, forKey: "time")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadData(){
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            if let data = NSData(contentsOfFile: path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                currentCity = unarchiver.decodeObjectForKey("CurrentCity") as! String
                cities = unarchiver.decodeObjectForKey("Cities") as! [City]
                weatherResult.weatherNowShow = unarchiver.decodeObjectForKey("weatherNowShow") as! [String]
                weatherResult.weatherToday = unarchiver.decodeObjectForKey("weatherToday") as! String
                weatherResult.weatherPoem = unarchiver.decodeObjectForKey("weatherPoem") as! [String]
                weatherResult.weatherForecasts = unarchiver.decodeObjectForKey("weatherForecasts") as! [[String]]
                weatherResult.weatherDate = unarchiver.decodeObjectForKey("weatherDate") as! [String]
                weatherResult.location = unarchiver.decodeObjectForKey("location") as! String
                weatherResult.time = unarchiver.decodeObjectForKey("time") as! String
                unarchiver.finishDecoding()
            }
        }
    }


}
