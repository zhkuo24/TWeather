//
//  WeatherService.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/17.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

typealias ResultComplete = (Bool) -> Void
class WeatherService: NSObject {
    
    enum State{
        case Loading
        case NoRequest
        case NonsupportCity
        case NoYet
        case Results(WeatherResult)
    }
    
    private(set) var state: State = .NoYet
    
    func FetchWeatherResult(cityName: String, finished: ResultComplete) {
        if !cityName.isEmpty {
            let url = citySearchText(cityName)
            var success = false
            Alamofire.request(.GET, url, encoding: .URL, headers: nil).responseJSON { (response) in
                if response.result.isSuccess {
                    if let jsonValue  = response.result.value{
                        success = true
                        let weatherData = JSON(jsonValue)
                        let weatherinfo = self.parseWeatherJSON(weatherData)
                        if weatherinfo.ServiceStatus == "no more requests" {
                            self.state = .NoRequest
                        }else if weatherinfo.ServiceStatus == "unknown city" {
                            self.state = .NonsupportCity
                        }else {
                            self.state = .Results(weatherinfo)
                        }
                        finished(success)
                    }
                }else {
                    success = false
                    finished(success)
                }
            }
        }
    }
    
    /**
     解析JSON天气信息
     */
    private func parseWeatherJSON(data: JSON) -> WeatherResult {
        
        let weatherData = data["HeWeather data service 3.0"][0]
        let weatherResult = WeatherResult()
        if let serviceState = weatherData["status"].string {
            weatherResult.ServiceStatus = serviceState
        }
        if let city = weatherData["basic"]["city"].string {
            weatherResult.city = city
        }
        if let condTxt = weatherData["now"]["cond"]["txt"].string {
            weatherResult.weatherNow.condTxt = condTxt
        }
        if let tmp = weatherData["now"]["tmp"].string {
            weatherResult.weatherNow.tmp = tmp
        }
        if let windDir = weatherData["now"]["wind"]["dir"].string {
            weatherResult.weatherNow.windDir = windDir
        }
        if let windSc = weatherData["now"]["wind"]["sc"].string {
            weatherResult.weatherNow.windSc = windSc
        }
        if let qlty = weatherData["aqi"]["city"]["qlty"].string {
            if qlty.characters.count < 3 {
                weatherResult.weatherNow.qlty = "空气质量" + qlty
            }else {
                weatherResult.weatherNow.qlty = String(weatherData["aqi"]["city"]["qlty"])
            }
        }
        
        //        print(weatherData["daily_forecast"][0]["cond"]["txt_d"])
        //        var forecast = dailyForecast(date: "", condTxtd: "", tmpMax: "", tmpMin: "", windDir: "", windSc: "")
        
        
        for i in 0...3 {
            let forecast = DailyResult()
            if let condTxtd = weatherData["daily_forecast"][i]["cond"]["txt_d"].string {
                forecast.condTxtd = condTxtd
            }
            if let condTxtn = weatherData["daily_forecast"][i]["cond"]["txt_n"].string {
                forecast.condTxtn = condTxtn
            }
            if let date = weatherData["daily_forecast"][i]["date"].string {
                forecast.date = date
            }
            if let tmpMax = weatherData["daily_forecast"][i]["tmp"]["max"].string {
                forecast.tmpMax = tmpMax
            }
            if let tmpMin = weatherData["daily_forecast"][i]["tmp"]["min"].string {
                forecast.tmpMin = tmpMin
            }
            if let windDir = weatherData["daily_forecast"][i]["wind"]["dir"].string {
                forecast.windDir = windDir
            }
            if let windSc = weatherData["daily_forecast"][i]["wind"]["sc"].string {
                forecast.windSc = windSc
            }
            weatherResult.forecasts.append(forecast)
//            weatherResult.forecasts[i] = forecast
        }
        let tmpInt: Int = Int(weatherResult.weatherNow.tmp) ?? 0
        var tmp:String = ""
        if tmpInt < 0 {
            tmp = "负" + numberToChineseWithUnit(abs(tmpInt))
        }else {
            tmp = numberToChineseWithUnit(tmpInt)
            
        }
        
//        weatherResult.weatherNowShow = weatherResult.weatherNow.condTxt + "<br>" + tmp + "度" + "<br>" + weatherResult.weatherNow.qlty +  "<br>"
        weatherResult.weatherNowShow.append(weatherResult.weatherNow.condTxt)
        weatherResult.weatherNowShow.append(tmp + "度")
        weatherResult.weatherNowShow.append(weatherResult.weatherNow.qlty)

//
        var poemArry: NSArray = poems[NSDate.SeasonNow()]!["其他"] as! NSArray
        if weatherResult.weatherNowShow[0].containsString("雨") {
            poemArry = poems[NSDate.SeasonNow()]!["雨"] as! NSArray
        }
        let index: Int = Int(arc4random() % 20)
        
        let poem1:String = poemArry[index]["one"] as! String
        let poem2:String = poemArry[index]["two"] as! String
//        let poem1:String = "海棠不惜胭脂色"
//        let poem2:String = "独立朦朦烟雨中"
        weatherResult.weatherPoem.append(poem1)
        weatherResult.weatherPoem.append(poem2)
        //TODO: - 修改
        weatherResult.location = weatherResult.city
        weatherResult.time = NSDate.date2ancientTime()
    
        
        //未来三天
        var date: String = ""
        for i in 0...3 {
            if weatherResult.forecasts[i].date[8..<9] == "0" {
                date = weatherResult.forecasts[i].date[9..<10]
            }else {
                date = weatherResult.forecasts[i].date[8...9]
            }
            let dateStr = numberToChineseWithUnit(Int(date) ?? 0) + "日"
            weatherResult.weatherDate.append(dateStr)
            
            
            let condd = weatherResult.forecasts[i].condTxtd
            let condn = weatherResult.forecasts[i].condTxtn
            let tmp1:Int = Int(weatherResult.forecasts[i].tmpMin) ?? 0
            let tmp2:Int = Int(weatherResult.forecasts[i].tmpMax) ?? 0
            var tmpMin: String = ""
            var tmpMax: String = ""
            if tmp1 < 0 {
                tmpMin = "负" + numberToChineseWithUnit(abs(tmp1)) + "度"
            }else {
                tmpMin = numberToChineseWithUnit(abs(tmp1)) + "度"
            }
            if tmp2 < 0 {
                tmpMax = "负" + numberToChineseWithUnit(abs(tmp2)) + "度"
            }else {
                tmpMax = numberToChineseWithUnit(tmp2) + "度"
            }
//            let tmpMin = numberToChineseWithUnit(Int(weatherResult.forecasts[i].tmpMin) ?? 0) + "度"
//            let tmpMax = numberToChineseWithUnit(Int(weatherResult.forecasts[i].tmpMax) ?? 0) + "度"
            let winddir = weatherResult.forecasts[i].windDir
            let winscTmp = weatherResult.forecasts[i].windSc as String
            var winsc: String = ""
            if winscTmp == "微风" {
                winsc = "一级"
            } else{
                winsc = numberToChineseWithUnit(Int(String(winscTmp[winscTmp.startIndex])) ?? 0) + "级"
            }
            
            var wind: String = ""
            if winddir == "无持续风向" {
                wind = "无风向"
            }else {
                wind = winddir + winsc
            }
            
//            var weather = cond + "<br>" + tmpMin + "<br>" + tmpMax + "<br>" + wind +  "<br>"
            var weather: [String] = [String]()
            if i == 0 {
                weather.append("日间" + condd)
                weather.append(tmpMin)
                weather.append(tmpMax)
                weather.append(wind)
                weather.append("夜间" + condn)
                
            }else {
                weather.append(condd)
                weather.append(tmpMin)
                weather.append(tmpMax)
                weather.append(wind)
                weather.append("夜间" + condn)
            }
            
            
            weatherResult.weatherForecasts.append(weather)
            
            
        }
        return weatherResult
  
    }
    
    /**
     获取请求链接
     */
    private func citySearchText(searchText: String) -> NSURL{
        
        //api 每天免费请求次数3000,如果超过请求次数请自行注册
        //和风天气网址: http://www.heweather.com
        
        let apiKeyTest = "b50ba365dd554fc887f14699a6e30584"
        
        let escapedSearchText = searchText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let urlString = String(format: "https://api.heweather.com/x3/weather?city=%@&key="+apiKeyTest,escapedSearchText)
        let url = NSURL(string: urlString)
        return url!
    }
    

}
