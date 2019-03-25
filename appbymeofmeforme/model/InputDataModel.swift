//
//  InputDataModel.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/10.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class InputDataModel: NSObject {
    
    
    public let MORNING   :Float    = 50
    public let AM       :Float    = 100
    public let NOON     :Float    = 150
    public let PM       :Float    = 200
    public let EVENING  :Float    = 250
    public let NIGHT   :Float    = 300
    
    
    public var morning :Float      = DEFAULTVALUE
    public var am      :Float      = DEFAULTVALUE
    public var noon    :Float      = DEFAULTVALUE
    public var pm      :Float      = DEFAULTVALUE
    public var evening :Float      = DEFAULTVALUE
    public var night   :Float      = DEFAULTVALUE
}
