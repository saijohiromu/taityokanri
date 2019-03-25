//
//  conditionCheckModel.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/10.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

//グローバル定数
let DEFAULTVALUE : Float = 0.5



struct ConditionCheckModel{
    
    enum FirstSection: String{
        case Moning     = "朝"
        case AM         = "午前"
        case Noon       = "昼"
        case PM         = "午後"
        case Evening    = "夕方"
        case Night      = "夜"
        case Nil        = "無"
    }
    
    enum NotificationName: String{
        case FirstSection   = "firstSection"
        case SecondSection  = "secondSection"
    }
    
    enum UserInfoKey: String{
        case SectionKey         = "userinfokey"
        case Value              = "userinfovalue"
    }
    
    

}

func countEnumElements(test: (Int) -> Any?) -> Int{
    var i = 0
    while test(i) != nil{
        i += 1
    }
    return i
}
