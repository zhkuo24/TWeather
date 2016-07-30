//
//  AppDelegate.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/17.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit

var fontSize: CGFloat = 24
var margin: CGFloat = 20
var poems: NSDictionary!
//常量

var height1: CGFloat = 0
var height2: CGFloat = 0
var height3: CGFloat = 0
var height4: CGFloat = 0
var height5: CGFloat = 0
var height6: CGFloat = 0
var height7: CGFloat = 0
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var weatherData = WeatherData()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //根据不同屏幕尺寸设置字体大小
        let deviceWidth: CGFloat = UIScreen.mainScreen().bounds.width
        switch deviceWidth {
        case 320:
            fontSize = 18.0
            margin = 18.0
        case 375:
            fontSize = 20.0
            margin = 20.0
        case 414:
            fontSize = 23.0
            margin = 23.0
        default: break
            
        }
        height1 =  verticalStrHeight(1,fontSize: fontSize).height
        height2 =  verticalStrHeight(5,fontSize: fontSize).height
        height3 =  verticalStrHeight(7,fontSize: fontSize).height
        height4 =  verticalStrHeight(4,fontSize: fontSize - 4).height
        height5 =  verticalStrHeight(3,fontSize: fontSize - 4).height
        height6 =  verticalStrHeight(2,fontSize: fontSize).height
        height7 =  verticalStrHeight(3,fontSize: fontSize).height
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor(red: 248/255.0, green: 248/255, blue: 246/255.0, alpha: 1)
        let controller = HomeViewController()
        controller.weatherData = weatherData

        window?.rootViewController = controller
        
        window?.makeKeyAndVisible()
        
//        NSThread.sleepForTimeInterval(0.75)

        poems = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("poems", ofType: "plist")!))!

        return true
    }
    

    func applicationWillResignActive(application: UIApplication) {
        weatherData.saveData()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        weatherData.saveData()
    }


}

