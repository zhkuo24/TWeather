//
//  CityListViewController.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/21.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit
import SnapKit
import Spring
protocol CityListViewControllerDelegate: class{
    func cityListViewControolerDidSelectCity(controller: CityListViewController, didSelectCity city: City)
    func cityListViewControllerCancel(controller: CityListViewController)
    func cityListViewControllerDeleteCity(controller: CityListViewController, currentCities cities: [City])
}
class CityListViewController: UIViewController {
    
    var cities = [City]()
    var filteredCities = [City]()
    var parserCities = [City]()
    var parserXML:ParserXML!
    var headerYCons: Constraint?
    weak var delegate: CityListViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        steupUI()
        headerView.animate()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate  = self
        
        let cellNIb = UINib(nibName: "CityListCell", bundle: nil)
        tableView.registerNib(cellNIb, forCellReuseIdentifier: "CityListCell")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit{
        parserXML = nil
        filteredCities = []
        searchBar.delegate = nil
    }
    
    //MARK: - 隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MAEK: - 初始化UI
    private func steupUI() {
        
        view.addSubview(tableView)
        view.addSubview(headerView)
        headerView.addSubview(searchBar)
        tableView.snp_makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(view)
        }
        headerView.snp_makeConstraints { (make) in
            self.headerYCons = make.bottom.equalTo(view.snp_top).offset(0).constraint
            make.size.equalTo(CGSize(width: UIScreen.mainScreen().bounds.width, height: 44))
            
        }
        searchBar.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(headerView)
        }
        headerView.animation = "squeezeDown"
        headerView.curve = "easeInOut"
        headerView.duration = 1
        
    
    }
    
    
    func filterControllerForSearchText(searchText: String, scope: String = "ALL"){
        filteredCities = parserCities.filter({ (city) -> Bool in
            return city.cityCN.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }
    

    lazy var tableView: UITableView = {
       
        let tv = UITableView()
        tv.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        tv.backgroundColor = UIColor.mybgclor()
        return tv
    }()
    
    lazy var headerView: SpringView = {
        let hv = SpringView()
        hv.backgroundColor = UIColor.mybgclor()
       return hv
    }()
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "输入城市名(下拉关闭视图)"
        sb.backgroundColor = UIColor.mybgclor()
//        sb.barTintColor = UIColor.mybgclor()
//        sb.setba
       return sb
    }()

}



extension CityListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filterControllerForSearchText(searchBar.text!)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if parserCities.isEmpty{
            parserXML = ParserXML()
            parserCities = parserXML.cities
        }
        
        filterControllerForSearchText(searchText)
    }
}

extension CityListViewController : UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let delegate = delegate {
            let city: City
            
            if !filteredCities.isEmpty {
                city = filteredCities[indexPath.row]
            }else {
                city = cities[indexPath.row]
            }
            delegate.cityListViewControolerDidSelectCity(self, didSelectCity: city)
        }
        searchBar.resignFirstResponder()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchBar.text != ""{
            return false
        }else{
            return true
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        cities.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        delegate?.cityListViewControllerDeleteCity(self, currentCities: cities)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        searchBar.resignFirstResponder()
        if offSetY < -44 {
            headerYCons?.updateOffset(44 - (abs(offSetY) - 44))
        }else{
            headerYCons?.updateOffset(44)
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        if decelerate && offsetY < -110 {
            headerView.hidden = true
            delegate?.cityListViewControllerCancel(self)
        }
    }


}


extension CityListViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let city: City
        if searchBar.text != "" {
            let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath)
            cell.textLabel?.textColor = UIColor.blackColor()
            city = filteredCities[indexPath.row]
            cell.textLabel?.text = city.cityCN
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CityListCell", forIndexPath: indexPath) as! CityListCell
            city = cities[indexPath.row]
            cell.addCityName(city)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredCities.isEmpty || searchBar.text != "" {
            return filteredCities.count
        }
        return cities.count
    }
    
}










