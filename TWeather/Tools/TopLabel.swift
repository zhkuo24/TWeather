//
//  TopLabel.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/19.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import UIKit

class TopLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect: CGRect = super.textRectForBounds(bounds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.y = bounds.origin.y
        return textRect
    }
    override func drawTextInRect(rect: CGRect) {
        let actualRext: CGRect = self.textRectForBounds(rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawTextInRect(actualRext)
    }

}
