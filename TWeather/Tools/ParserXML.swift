//
//  ParserXML.swift
//  TWeather
//
//  Created by zhangkuo on 16/7/16.
//  Copyright © 2016年 zhangkuo. All rights reserved.
//

import Foundation

class ParserXML: NSObject,NSXMLParserDelegate{
    
    private var elementName = ""
    var cities = [City]()
    
    override init(){
        super.init()
        parseXMLResource()
    }
    
    private func parseXMLResource(){
        let parser = NSXMLParser(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Citys", ofType: "xml")!))
        if let parser = parser{
            parser.delegate = self
            parser.parse()
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.elementName = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let str = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if elementName == "city"{
            let city = City()
            //      print("xml 解析完成")
            city.cityCN = str
            cities.append(city)
        }
    }
    
    func rangeOfLocation(placemark: String) -> String {
        var cityName: String!
        let p = placemark.lowercaseString
        for (_ , value) in cities.enumerate(){
            if p.rangeOfString(value.cityCN) != nil{
                cityName =  value.cityCN
                break
            } else {
                cityName = placemark
            }
        }
        return cityName
    }
}