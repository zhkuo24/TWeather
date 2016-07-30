//
//  CityListCell.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/21.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit

class CityListCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    func addCityName(city: City) {
        cityLabel.text = city.cityCN
    }

}
