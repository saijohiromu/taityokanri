//
//  SectionTitleViewX.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/03/02.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class SectionTitleViewX: UIView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBAction func sectionButton(_ sender: UIButton) {
        print("section id: \(sectionId)")
    }
    
    var sectionId: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("SectionTitleViewX init")
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) { //ストーリーボード から呼ばれる際使用
        super.init(coder: aDecoder)
        print("SectionTitleViewX decoder")
        loadNib()
    }
    
    func loadNib(){
        let view = Bundle.main.loadNibNamed("SectionTitleView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.backgroundColor = UIColor.lightLightPrimary
        self.addSubview(view)
    }

}
