//
//  Logger.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/10.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class Logger: NSObject {
        
    private let formatter = DateFormatter()
    private let jstformatter = DateFormatter()
    private var flag = false
    
    convenience init(_ bool: Bool){
        self.init()
        flag = bool
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        jstformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        jstformatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        jstformatter.locale = Locale(identifier: "en_US_POSIX")
    }
    
    public func logger(_ debug: Any = "", function: String = #function, file: String = #file, line: Int = #line){
        if flag == true{
            let strArr = file.components(separatedBy: "/")
            let filename = strArr.last
            print("\(getExactUTCTimeString()),\(filename ?? ""),\(line),\(function),\(debug)")
            //print("File:\(filename ?? ""),l\(line),debug:\(debug)")
        }
    }
    
    public func getExactUTCTimeString() -> String{
        let now = Date()
        return formatter.string(from: now)
    }
    
    public func getExactJSTTimeString() -> String{
        let now = Date()
        return jstformatter.string(from: now)
    }
    
    
    

}
