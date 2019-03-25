//
//  SharedInputDataManager.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/10.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class SharedInputDataManager: NSObject {
    
    public static let shared = SharedInputDataManager()
    
    var viewInputedData: InputDataModel = InputDataModel()
    

}
