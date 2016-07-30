//
//  WeatherScrollView.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/19.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit
import MJRefresh
import Spring

class WeatherScrollView: UIScrollView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
//    var weatherInfo: WeatherResult?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.mybgclor()
        showsVerticalScrollIndicator = false
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func updateWeatherInfo(weatherResult: WeatherResult) {
        
        nowLabel1.text = weatherResult.weatherNowShow[0]
        nowLabel2.text = weatherResult.weatherNowShow[1]
        nowLabel3.text = weatherResult.weatherNowShow[2]
        
        poemLabel1.text = weatherResult.weatherPoem[0]
        poemLabel2.text = weatherResult.weatherPoem[1]
        
        todayLabel1.text = weatherResult.weatherForecasts[0][0]
        todayLabel2.text = weatherResult.weatherForecasts[0][1]
        todayLabel3.text = weatherResult.weatherForecasts[0][2]
        todayLabel4.text = weatherResult.weatherForecasts[0][3]
        todayLabel5.text = weatherResult.weatherForecasts[0][4]
        
        cityLabel.text = weatherResult.city
        timeLabel.text = weatherResult.time
        
        if weatherResult.city == "" {
            cityOval.hidden = true
        }else {
            cityOval.hidden = false
        }
        
        if weatherResult.time == "" {
            timeOval.hidden = true
        }else {
            timeOval.hidden = false
        }
        
        
        forecast1Label1.text = weatherResult.weatherDate[1]
        forecast1Label2.text = weatherResult.weatherForecasts[1][0]
        forecast1Label3.text = weatherResult.weatherForecasts[1][1]
        forecast1Label4.text = weatherResult.weatherForecasts[1][2]
        forecast1Label5.text = weatherResult.weatherForecasts[1][3]
        
        forecast2Label1.text = weatherResult.weatherDate[2]
        forecast2Label2.text = weatherResult.weatherForecasts[2][0]
        forecast2Label3.text = weatherResult.weatherForecasts[2][1]
        forecast2Label4.text = weatherResult.weatherForecasts[2][2]
        forecast2Label5.text = weatherResult.weatherForecasts[2][3]
        
        forecast3Label1.text = weatherResult.weatherDate[3]
        forecast3Label2.text = weatherResult.weatherForecasts[3][0]
        forecast3Label3.text = weatherResult.weatherForecasts[3][1]
        forecast3Label4.text = weatherResult.weatherForecasts[3][2]
        forecast3Label5.text = weatherResult.weatherForecasts[3][3]
        
        
        
    }
    
    func pageControl(pageFlag: Bool) {
        nowContainerView.hidden = !pageFlag
        poemContainerView.hidden = !pageFlag
        todayContainerView.hidden = !pageFlag
        
        forecastView1.hidden = pageFlag
        forecastView2.hidden = pageFlag
        forecastView3.hidden = pageFlag
    }
    
    
    func setupUI() {
        //添加子控件
//        
        addSubview(containerView)
        addSubview(nowContainerView)
        addSubview(poemContainerView)
        addSubview(todayContainerView)
        addSubview(cityTimeContainerView)
        nowContainerView.addSubview(nowLabel1)
        nowContainerView.addSubview(nowLabel2)
        nowContainerView.addSubview(nowLabel3)
        poemContainerView.addSubview(poemLabel1)
        poemContainerView.addSubview(poemLabel2)
        todayContainerView.addSubview(todayLabel1)
        todayContainerView.addSubview(todayLabel2)
        todayContainerView.addSubview(todayLabel3)
        todayContainerView.addSubview(todayLabel4)
        todayContainerView.addSubview(todayLabel5)
        cityTimeContainerView.addSubview(cityOval)
        cityTimeContainerView.addSubview(timeOval)
        cityTimeContainerView.addSubview(cityLabel)
        cityTimeContainerView.addSubview(timeLabel)
        
        addSubview(forecastView1)
        addSubview(forecastView2)
        addSubview(forecastView3)
        
        forecastView1.addSubview(forecast1Label1)
        forecastView1.addSubview(forecast1Label2)
        forecastView1.addSubview(forecast1Label3)
        forecastView1.addSubview(forecast1Label4)
        forecastView1.addSubview(forecast1Label5)
        
        forecastView2.addSubview(forecast2Label1)
        forecastView2.addSubview(forecast2Label2)
        forecastView2.addSubview(forecast2Label3)
        forecastView2.addSubview(forecast2Label4)
        forecastView2.addSubview(forecast2Label5)
        
        forecastView3.addSubview(forecast3Label1)
        forecastView3.addSubview(forecast3Label2)
        forecastView3.addSubview(forecast3Label3)
        forecastView3.addSubview(forecast3Label4)
        forecastView3.addSubview(forecast3Label5)
        
        

        
        
  
        
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(UIScreen.mainScreen().bounds.height)
            make.width.equalTo(UIScreen.mainScreen().bounds.width)
        }
        
        nowContainerView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize * 3 + margin * 2, height2))
            make.right.equalTo(self).offset(-fontSize*3 - margin)
            make.top.equalTo(self).offset(height7)
        }
        poemContainerView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize * 2 + margin * 1, height3))
            make.right.equalTo(self).offset(-fontSize*3 - margin)
            make.top.equalTo(nowContainerView.snp_bottom).offset(height7)
        }
        todayContainerView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize * 5 + margin * 4, height2))
            make.right.equalTo(self).offset(-fontSize*3 - margin)
            make.top.equalTo(poemContainerView.snp_bottom).offset(height7)
        }
        
        nowLabel1.snp_makeConstraints { (make) in
            make.top.right.equalTo(nowContainerView)
            make.size.equalTo(CGSizeMake(fontSize, height2))
        }
        nowLabel2.snp_makeConstraints { (make) in
            make.top.equalTo(nowContainerView)
            make.right.equalTo(nowLabel1.snp_left).offset(-margin)
            make.size.equalTo(CGSizeMake(fontSize, height2))
        }
        nowLabel3.snp_makeConstraints { (make) in
            make.top.equalTo(nowContainerView)
            make.right.equalTo(nowLabel2.snp_left).offset(-margin)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        poemLabel1.snp_makeConstraints { (make) in
            make.top.right.equalTo(poemContainerView)
            make.size.equalTo(CGSizeMake(fontSize, height3 + 0.5))
        }
        poemLabel2.snp_makeConstraints { (make) in
            make.top.equalTo(poemContainerView)
            make.right.equalTo(poemLabel1.snp_left).offset(-margin)
            make.size.equalTo(CGSizeMake(fontSize, height3 + 0.5))
        }
        
        todayLabel1.snp_makeConstraints { (make) in
            make.top.right.equalTo(todayContainerView)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        todayLabel2.snp_makeConstraints { (make) in
            make.top.equalTo(todayContainerView)
            make.right.equalTo(todayLabel1.snp_left).offset(-margin)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        todayLabel3.snp_makeConstraints { (make) in
            make.top.equalTo(todayContainerView)
            make.right.equalTo(todayLabel2.snp_left).offset(-margin)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        todayLabel4.snp_makeConstraints { (make) in
            make.top.equalTo(todayContainerView)
            make.right.equalTo(todayLabel3.snp_left).offset(-margin)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        todayLabel5.snp_makeConstraints { (make) in
            make.top.equalTo(todayContainerView)
            make.right.equalTo(todayLabel4.snp_left).offset(-margin)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        
        cityTimeContainerView.snp_makeConstraints { (make) in
            make.bottom.equalTo(todayContainerView)
            make.left.equalTo(self).offset(margin)
            make.size.equalTo(CGSizeMake((fontSize - 6) * 2 + 5, height4))
            
        }
        
        cityOval.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize - 6, fontSize - 5))
            make.top.right.equalTo(cityTimeContainerView)
        }
        timeOval.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize - 6, fontSize - 5))
            make.top.equalTo(cityTimeContainerView)
            make.right.equalTo(cityOval.snp_left).offset(-8)
        }
        
        cityLabel.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize - 6, height5 + 0.5))
            make.top.equalTo(cityOval.snp_bottom)
            make.right.equalTo(cityTimeContainerView)
        }
        timeLabel.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize - 6, height5 + 0.5))
            make.top.equalTo(timeOval.snp_bottom)
            make.right.equalTo(cityLabel.snp_left).offset(-8)
        }
        
        
        
        forecastView1.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize * 5 + margin * 4, height2))
            make.right.equalTo(self).offset(-fontSize*3 - margin)
            make.top.equalTo(self).offset(height7)
        }
        forecastView2.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize * 5 + margin * 4, height2))
            make.right.equalTo(self).offset(-fontSize*3 - margin)
            make.top.equalTo(forecastView1.snp_bottom).offset(height7)
        }
        forecastView3.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(fontSize * 5 + margin * 4, height2))
            make.right.equalTo(self).offset(-fontSize*3 - margin)
            make.top.equalTo(forecastView2.snp_bottom).offset(height7)
        }
        
        
        
        
        forecast1Label1.snp_makeConstraints { (make) in
            make.top.right.equalTo(forecastView1)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast1Label2.snp_makeConstraints { (make) in
            make.top.equalTo(forecastView1)
            make.right.equalTo(forecast1Label1.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast1Label3.snp_makeConstraints { (make) in
            make.top.equalTo(forecastView1)
            make.right.equalTo(forecast1Label2.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast1Label4.snp_makeConstraints { (make) in
            make.top.equalTo(forecastView1)
            make.right.equalTo(forecast1Label3.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast1Label5.snp_makeConstraints { (make) in
            make.top.equalTo(forecast1Label4)
            make.right.equalTo(forecast1Label4.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        
        
        forecast2Label1.snp_makeConstraints { (make) in
            make.top.right.equalTo(forecastView2)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast2Label2.snp_makeConstraints { (make) in
            make.top.equalTo(forecastView2)
            make.right.equalTo(forecast2Label1.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast2Label3.snp_makeConstraints { (make) in
            make.top.equalTo(forecastView2)
            make.right.equalTo(forecast2Label2.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast2Label4.snp_makeConstraints { (make) in
            make.top.equalTo(forecastView2)
            make.right.equalTo(forecast2Label3.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast2Label5.snp_makeConstraints { (make) in
            make.top.equalTo(forecast2Label4)
            make.right.equalTo(forecast2Label4.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }

        forecast3Label1.snp_makeConstraints { (make) in
            make.top.right.equalTo(forecastView3)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast3Label2.snp_makeConstraints { (make) in
            make.top.equalTo(forecastView3)
            make.right.equalTo(forecast3Label1.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast3Label3.snp_makeConstraints { (make) in
            make.top.equalTo(forecastView3)
            make.right.equalTo(forecast3Label2.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast3Label4.snp_makeConstraints { (make) in
            make.top.equalTo(forecastView3)
            make.right.equalTo(forecast3Label3.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }
        forecast3Label5.snp_makeConstraints { (make) in
            make.top.equalTo(forecast3Label4)
            make.right.equalTo(forecast3Label4.snp_left).offset(-margin+8)
            make.size.equalTo(CGSizeMake(fontSize, height2 + 0.5))
        }


        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - 懒加载
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mybgclor()
        view.alpha = 0
        
        return view
    }()
    
    lazy var nowContainerView: SpringView = {
        let view = SpringView()
//        view.backgroundColor = UIColor.yellowColor()
//        view.layer.animation = "Shake"
//        view.curve = "EaseOut"
        view.alpha = 1
        
        return view
    }()
    lazy var poemContainerView: SpringView = {
        let view = SpringView()
        //        view.backgroundColor = UIColor.greenColor()
        return view
    }()
    lazy var todayContainerView: SpringView = {
        let view = SpringView()
        //        view.backgroundColor = UIColor.blueColor()
        return view
    }()
    lazy var cityTimeContainerView: SpringView = {
        let view = SpringView()
//        view.backgroundColor = UIColor.blueColor()
        return view
    }()
    //当天天气
    lazy var nowLabel1: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        
        label.numberOfLines = 10
        return label
    }()
    lazy var nowLabel2: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var nowLabel3: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    //诗句
    lazy var poemLabel1: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor2()
        label.numberOfLines = 10
        return label
    }()
    lazy var poemLabel2: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor2()
        label.numberOfLines = 10
        return label
    }()
    //今日天气
    lazy var todayLabel1: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var todayLabel2: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        
        return label
    }()
    lazy var todayLabel3: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var todayLabel4: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var todayLabel5: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    
    lazy var cityLabel: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize - 6)
        label.textColor = UIColor.mycolor2()
        label.numberOfLines = 3
        return label
    }()
    lazy var timeLabel: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize - 6)
        label.textColor = UIColor.mycolor2()
        label.numberOfLines = 3
        return label
    }()
    
    lazy var cityOval: UIImageView = {
        
        let image = UIImageView(image: UIImage(named: "oval"))
        image.hidden = true
        return image
    }()
    
    lazy var timeOval: UIImageView = {
        
        let image = UIImageView(image: UIImage(named: "oval"))
        image.hidden = true
        return image
    }()
    
    //第二页的控件
    lazy var forecastView1: SpringView = {
        let view = SpringView()

        
        return view
    }()
    
    lazy var forecastView2: SpringView = {
        let view = SpringView()
        
        
        return view
    }()
    lazy var forecastView3: SpringView = {
        let view = SpringView()
        return view
    }()
    
    
    //今日天气
    lazy var forecast1Label1: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var forecast1Label2: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        
        return label
    }()
    lazy var forecast1Label3: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var forecast1Label4: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var forecast1Label5: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    
    
    
    lazy var forecast2Label1: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var forecast2Label2: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        
        return label
    }()
    lazy var forecast2Label3: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var forecast2Label4: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var forecast2Label5: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    
    lazy var forecast3Label1: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var forecast3Label2: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        
        return label
    }()
    lazy var forecast3Label3: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var forecast3Label4: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    lazy var forecast3Label5: TopLabel = {
        let label = TopLabel()
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: fontSize)
        label.textColor = UIColor.mycolor3()
        label.numberOfLines = 10
        return label
    }()
    
    
    
    
    
    
    

}
