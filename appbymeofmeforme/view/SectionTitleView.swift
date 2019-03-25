//
//  SectionTitleView.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/03/02.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class SectionTitleView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var titleId: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) { //ストーリボードから呼ばれる
        super.init(coder: aDecoder)
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        print("titleId: \(titleId)")
    }
    
    
}
