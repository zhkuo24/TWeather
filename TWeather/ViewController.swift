//
//  ViewController.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/18.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit
//import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view = ShowInfo()
        let str: NSString = "海\n棠\n不\n惜\n惜\n惜\n惜\n棠\n不\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜"
        let size = str.sizeWithAttributes([NSFontAttributeName: sampleLabel.font])
//        view.addSubview(sampleLabel)
//        view.addSubview(sampleLabel1)
//        view = ShowInfo()
        sampleLabel.frame = CGRectMake(150, 0, size.width, size.height)
        sampleLabel1.frame = CGRectMake(150+52, 0, size.width, size.height)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //
    lazy var sampleLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(150, 0, 40, 736))
        label.text = "海\n棠\n不\n惜\n惜\n惜\n惜\n棠\n不\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜"
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: 28)
        label.numberOfLines = 30
//        label.adjustsFontSizeToFitWidth = true
//        label.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        
       
        label.backgroundColor = UIColor.yellowColor()
        return label
    }()
    lazy var sampleLabel1: UILabel = {
        let label = UILabel(frame: CGRectMake(150, 0, 40, 736))
        label.text = "海\n棠\n不\n惜\n惜\n惜\n惜\n棠\n不\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜\n惜"
        label.font = UIFont(name: "FZLongZhaoT-R-GB", size: 28)
        label.numberOfLines = 30
        //        label.adjustsFontSizeToFitWidth = true
        //        label.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        
        
        label.backgroundColor = UIColor.yellowColor()
        return label
    }()

}
