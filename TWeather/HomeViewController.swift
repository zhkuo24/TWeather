//
//  HomeViewController.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/19.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

var pageFlag:Bool = true

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    var fromRightSwip: UISwipeGestureRecognizer!
    var fromLeftSwip: UISwipeGestureRecognizer!
    var tap: UITapGestureRecognizer!
    let weatherView = WeatherScrollView(frame: UIScreen.mainScreen().bounds)
    var weatherService = WeatherService()
    var weatherData: WeatherData!
    var observer: AnyObject!
    var buttonClicked: Bool = false
    let refreshPoem1 = ["未觉池塘春草梦","无可奈何花落去","莫见长安行乐处","世人若被明日累","花开堪摘直须摘","山川满目泪沾衣","花儿还有重开日"]
    let refreshPoem2 = ["阶前梧叶已秋声","似曾相识燕归来","空令岁月易蹉跎","春去秋来老将至","莫待花落空摘枝","富贵荣华能几时","人生没有再少年"]
    let refreshPoem3 = ["人寿几何","逝者如斯夫","只争朝夕","日月如梭","今日复今日","及时当勉励","岁去弦吐箭"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
       
        view.addSubview(weatherView)

        weatherView.delegate = self
        weatherView.pageControl(pageFlag)
        configRefresh()
        configTapGes()
        listenForLocation()
//        updateWeatherResult()
        //TODO: - 启动动画
        launchAnimation(view) { (finishion) in
            if finishion {
                self.updateWeatherResult()
            }
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 更新天气信息
    func updateWeatherResult(){
        
        if weatherData.currentCity == "" || buttonClicked == true{
            buttonClicked = false
            locationCity()
        }else{
            loadWeatherInfo()
        }
    }
    
    //MARK: - 增加动画
    func animationPageOne() {
        weatherView.nowContainerView.animation = "squeezeDown"
        weatherView.nowContainerView.curve = "spring"
        weatherView.nowContainerView.delay = 0.1
        weatherView.nowContainerView.duration = 1
        weatherView.nowContainerView.animate()
        
        weatherView.todayContainerView.animation = "squeezeUp"
        weatherView.todayContainerView.curve = "spring"
        weatherView.todayContainerView.delay = 0.1
        weatherView.todayContainerView.duration = 1
        weatherView.todayContainerView.animate()
        
        weatherView.cityTimeContainerView.animation = "pop"
        weatherView.cityTimeContainerView.curve = "spring"
        weatherView.cityTimeContainerView.delay = 0.1
        weatherView.cityTimeContainerView.duration = 1.5
        weatherView.cityTimeContainerView.animate()
        
 
        weatherView.poemContainerView.animation = "slideLeft"
        weatherView.poemContainerView.curve = "spring"
        weatherView.poemContainerView.delay = 0.1
        weatherView.poemContainerView.damping = 0.5
        weatherView.poemContainerView.velocity = 0.5
        weatherView.poemContainerView.duration = 1.5
        weatherView.poemContainerView.animate()
        
    }
    
    func animationPageTwo(delay: CGFloat) {
        weatherView.forecastView1.animation = "slideLeft"
        weatherView.forecastView1.curve = "spring"
        weatherView.forecastView1.delay = delay
        weatherView.forecastView1.damping = 0.5
        weatherView.forecastView1.velocity = 0.5
        weatherView.forecastView1.duration = 1.5
        weatherView.forecastView1.animate()
        
        weatherView.forecastView2.animation = "slideLeft"
        weatherView.forecastView2.curve = "spring"
        weatherView.forecastView2.delay = delay
        weatherView.forecastView2.damping = 0.5
        weatherView.forecastView2.velocity = 0.5
        weatherView.forecastView2.duration = 1
        weatherView.forecastView2.animate()
        
        weatherView.forecastView3.animation = "slideLeft"
        weatherView.forecastView3.curve = "spring"
        weatherView.forecastView3.delay = delay
        weatherView.forecastView3.damping = 0.5
        weatherView.forecastView3.velocity = 0.5
        weatherView.forecastView3.duration = 1
        weatherView.forecastView3.animate()
        
        weatherView.cityTimeContainerView.animation = "pop"
        weatherView.cityTimeContainerView.curve = "spring"
        weatherView.cityTimeContainerView.delay = 0.5
        weatherView.cityTimeContainerView.duration = 1.5
        weatherView.cityTimeContainerView.animate()
        
        
    }
   
    
    //MARK: -  添加手势
    func configTapGes() {
        fromRightSwip = UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.nextPage))
        fromRightSwip.direction = UISwipeGestureRecognizerDirection.Left
        self.weatherView.addGestureRecognizer(fromRightSwip)
        
        fromLeftSwip = UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.forwadPage))
        fromLeftSwip.direction = UISwipeGestureRecognizerDirection.Right
        self.weatherView.addGestureRecognizer(fromLeftSwip)
//        
        tap = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.tapLocationCity))
        tap.numberOfTapsRequired = 1;
        self.weatherView.cityTimeContainerView.addGestureRecognizer(tap)
        self.weatherView.cityTimeContainerView.userInteractionEnabled = true
        
        
    }
    
    func tapLocationCity() {

        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Custom)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
        SVProgressHUD.setFont(UIFont(name: "FZLongZhaoT-R-GB", size: 18))
        SVProgressHUD.setBackgroundColor(UIColor.mybgclor())
        SVProgressHUD.setForegroundColor(UIColor.mycolor3())
        SVProgressHUD.setRingRadius(10)
        SVProgressHUD.setBackgroundLayerColor(UIColor.blueColor())
        SVProgressHUD.showWithStatus("定位中...")
        buttonClicked = true
        updateWeatherResult()
        
        
        
    }
   
//
    func nextPage() {
        if pageFlag {
            transitionWithType("pageCurl", subType: kCATransitionFromRight, view: self.weatherView)
            pageFlag = false
            weatherView.pageControl(pageFlag)
            animationPageTwo(0.3)
            
        }
        
    }
    
    func forwadPage() {
        if !pageFlag {
            transitionWithType("pageCurl", subType: kCATransitionFromLeft, view: self.weatherView)
            pageFlag = true
            weatherView.pageControl(pageFlag)
            animationPageOne()
        }
    }
    
    //MARK: - 动画效果实现
    func transitionWithType(type: String, subType: String, view: UIView) {
        
        let animation:CATransition = CATransition()
        animation.duration = 0.7
        animation.type = type
        animation.subtype = subType
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.layer.addAnimation(animation, forKey: "animation")
        
    }
    
    
    //MARK: - 配置刷新
    private func configRefresh() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.RefreshWeatherInfo))
        //设置文字
//        header.setTitle("世人若被明日累", forState: MJRefreshState.Idle)
//        header.setTitle("春去秋来老将至", forState: MJRefreshState.Pulling)
//        header.setTitle("光阴如梭", forState: MJRefreshState.Refreshing)
        header.setTitle("未觉池塘春草梦", forState: MJRefreshState.Idle)
        header.setTitle("阶前梧叶已秋声", forState: MJRefreshState.Pulling)
        header.setTitle("岁去弦吐箭", forState: MJRefreshState.Refreshing)
        //设置字体
        header.stateLabel.font = UIFont(name: "FZLongZhaoT-R-GB", size: 15)
        header.lastUpdatedTimeLabel.font = UIFont(name: "FZLongZhaoT-R-GB", size: 14)
        header.lastUpdatedTimeLabel.hidden = true

        weatherView.mj_header = header
    }
    
    func ShowCityListView() {
        let vc = CityListViewController()
        vc.delegate = self
        vc.cities = weatherData.cities
        presentViewController(vc, animated: true) {
            vc.headerView.animate()
        }
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if weatherView.contentOffset.y > 60 {
            ShowCityListView()
        }
    }
    func RefreshWeatherInfo() {
        loadWeatherInfo()
        
        
        
    }
    
    //MARK: - 刷新显示信息
    func updateUI() {
        
        weatherView.updateWeatherInfo(weatherData.weatherResult)
        
    }
    
    func listenForLocation() {
        observer = NSNotificationCenter.defaultCenter().addObserverForName("Location_Denied", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { [weak self](_) in
            SVProgressHUD.dismiss()
            self?.showAlert("没有打开定位服务请在设置中打开定位或上拉搜索选择城市", atctionTitle: "好的", againReuqest: false, requestFlag: false)
            })
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
    
    
    
    //MARK: - 隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    //MARK: - 加载天气数据
    func loadWeatherInfo() {
        weatherService.FetchWeatherResult(weatherData.currentCity) { (sucess) in
            if sucess {
                
                switch self.weatherService.state{
                case .Loading: break
                case .Results(let result):
                    self.weatherData.weatherResult = result
                    self.updateUI()
                    self.weatherView.mj_header.endRefreshing()
                    if pageFlag {
                        self.animationPageOne()
                    }else {
                        self.animationPageTwo(0.1)
                    }
                    
                    
                case .NoRequest:
                    let message = "服务器请求已经超过访问次数,请明天再试"
                    self.showAlert(message,atctionTitle: "好的", againReuqest: false, requestFlag: true)
                case .NonsupportCity:
                    self.weatherData.currentCity = ""
                    let message = "很抱歉,服务器暂不支持此城市,请在城市搜索界面查找其他城市"
                    self.showAlert(message, atctionTitle: "好的", againReuqest: false, requestFlag: true)
                    break
                case .NoYet:
                    return
                }
                
            }else {
                let message = "网络请求出现错误,请稍后重试"
                self.showAlert(message,atctionTitle: "取消", againReuqest: true, requestFlag: true)
            }
        }
        
    }
    
    //MARK: - 定位城市
    func locationCity(){
        LocationService.startLocation()
        LocationService.sharedManager.afterUpdatedCityAction = {
            [weak self] sucess in
            if !sucess{
                SVProgressHUD.dismiss()
                let message = "定位失败,请稍后重试或上滑视图打开城市搜索"
                self?.showAlert(message, atctionTitle: "好的", againReuqest: false, requestFlag: false)
            }
            self?.showLocationStatus()
        }
//        showLocationStatus()
        //        SVProgressHUD.dismiss()
    }
    
    
    func showLocationStatus(){
        switch LocationService.sharedManager.locationStatus{
        case .Loading: break
            
        case .Result(let city):
            weatherData.currentCity = city
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        SVProgressHUD.dismiss()
                        self.loadWeatherInfo()
            })
//             self.loadWeatherInfo()
        case .Normal:
            return
        }
    }
    
    //MARK: - 显示提示信息
    func showAlert(message: String, atctionTitle: String, againReuqest: Bool, requestFlag: Bool) {
        let alertTitle = "发生错误"
        let alertStyle = UIAlertControllerStyle.Alert
        let actionDoneTitle = "重试"
        let alert = UIAlertController(title: alertTitle, message: message , preferredStyle: alertStyle)
        //        alert.
        //设置字体
        //        let alertTitleAttr = NSMutableAttributedString(string: alertTitle)
        //        alertTitleAttr.addAttributes([NSFontAttributeName : UIFont(name: "FZLongZhaoT-R-GB", size: 22)!], range: NSMakeRange(0, 4))
        //        alertTitleAttr.addAttributes([NSForegroundColorAttributeName : UIColor.mycolor2()], range: NSMakeRange(0, 4))
        //            alert.setValue(alertTitleAttr, forKey: "attributedTitle")
        //
        //        let alertMessageAttr = NSMutableAttributedString(string: message)
        //        alertMessageAttr.addAttributes([NSFontAttributeName : UIFont(name: "FZLongZhaoT-R-GB", size: 18)!], range: NSMakeRange(0, message.characters.count))
        //        alertMessageAttr.addAttributes([NSForegroundColorAttributeName : UIColor.mycolor3()], range: NSMakeRange(0, message.characters.count))
        //        alert.setValue(alertMessageAttr, forKey: "attributedMessage")
        
        let actionRequest = UIAlertAction(title: actionDoneTitle, style: .Default, handler: { (action) -> Void in
            if againReuqest && requestFlag {
//                self.collectionView?.mj_header.beginRefreshing()
            }
            if !requestFlag {
            }
            
        })
        actionRequest.setValue(UIColor.mycolor2(), forKey: "titleTextColor")
        alert.addAction(actionRequest)
        
        
        let actionCancel = UIAlertAction(title: atctionTitle, style: .Default, handler: {(_) in
        })
        
        actionCancel.setValue(UIColor.mycolor2(), forKey: "titleTextColor")
        alert.addAction(actionCancel)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    

}

extension HomeViewController: CityListViewControllerDelegate{
    
    func cityListViewControolerDidSelectCity(controller: CityListViewController, didSelectCity city: City) {
        
        weatherData.currentCity = city.cityCN
        loadWeatherInfo()
        weatherData.appendCity(city)
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func cityListViewControllerCancel(controller: CityListViewController) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    func cityListViewControllerDeleteCity(controller: CityListViewController, currentCities cities: [City]) {
        weatherData.cities = cities
        
    }
    
}



