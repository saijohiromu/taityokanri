//
//  BeziaPathTableViewCell.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/13.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class BeziaPathTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var drawViews: UIView!
    
    @IBOutlet weak var testLabel: UILabel!
    var textLabelFlag = true
    
    @IBOutlet weak var testLabelHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(section: String){
        if textLabelFlag == true{
            testLabel.isHidden = false
            testLabelHeight.constant = 50
            testLabel.text = "OmO"
            textLabelFlag = false
        }else{
            testLabel.isHidden = true
            testLabelHeight.constant = 0
            testLabel.text = "OmO"
            textLabelFlag = true
        }
//        let uiPath = UIBezierPath()
//        uiPath.move(to: CGPoint(x: 100, y: 100)) //ここから
//        uiPath.addLine(to: CGPoint(x: 300, y: 300)) //ここまで
//        uiPath.lineWidth = 5
//        uiPath.close()
//        UIColor.black.setStroke()
//        uiPath.stroke()
//        uiPath.fill()
    }
    
    override func draw(_ rect: CGRect) {
        let uiPath = UIBezierPath()
        uiPath.move(to: CGPoint(x: 100, y: 100)) //ここから
        uiPath.addLine(to: CGPoint(x: 300, y: 300)) //ここまで
        uiPath.lineWidth = 5
        uiPath.close()
        UIColor.black.setStroke()
        uiPath.stroke()
        uiPath.fill()
    }
    
    
    
}
