//
//  horizontalSliderTableViewCell.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/10.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class HorizontalSliderTableViewCell: UITableViewCell {
    
    private let logger = Logger(true)
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    
    var section: ConditionCheckModel.FirstSection!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(section: Any){
        self.backgroundColor = UIColor.lightLightLightPrimary
        self.section = section as? ConditionCheckModel.FirstSection ?? ConditionCheckModel.FirstSection.Nil
        self.label.text = self.section.rawValue
        self.label2.text = "\(slider.value)"
        self.slider.value = DEFAULTVALUE
    }
    
    @IBAction func inputSlider(_ sender: UISlider) {
        logger.logger("\(section.rawValue),\(sender.value)")
        let value = round(sender.value * 100000)/100000 //小数点以下切り捨て　100バイして小数点２桁まで
        self.label2.text = "\(value)"
        NotificationCenter.default.post(name: Notification.Name(ConditionCheckModel.NotificationName.FirstSection.rawValue), object: nil, userInfo: [ConditionCheckModel.UserInfoKey.SectionKey.rawValue:section.rawValue,ConditionCheckModel.UserInfoKey.Value.rawValue:value])
    }
    
}
