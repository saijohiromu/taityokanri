//
//  conditionCheckTableViewController.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/10.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class ConditionCheckTableViewController: UITableViewController {
    
    private let logger = Logger(true)
    
    var sectionTitleViews: [SectionTitleViewX] = []
    let sectionTitleHeight: CGFloat = 40
    
    
    @IBOutlet var firstSectionTitleView: SectionTitleView!
    
    
    enum CellFormat: String{
        case DEF     = "cell2"
        case SLIDER  = "cell"
        case GRAPH   = "cell3"
    }
    
  
    let sectionNum = 3
    var firstSectionId: [(Any,CellFormat,UITableViewCell)] = [
        (ConditionCheckModel.FirstSection.Moning, CellFormat.SLIDER,HorizontalSliderTableViewCell()),
        (ConditionCheckModel.FirstSection.AM, CellFormat.SLIDER,HorizontalSliderTableViewCell()),
        (ConditionCheckModel.FirstSection.Noon, CellFormat.SLIDER,HorizontalSliderTableViewCell()),
        (ConditionCheckModel.FirstSection.PM, CellFormat.SLIDER,HorizontalSliderTableViewCell()),
        (ConditionCheckModel.FirstSection.Evening, CellFormat.SLIDER,HorizontalSliderTableViewCell()),
        (ConditionCheckModel.FirstSection.Night, CellFormat.SLIDER,HorizontalSliderTableViewCell())
    ]
    
    let secondSectionId: [(Any,CellFormat,Any)] = [
        //("", CellFormat.GRAPH)
    ]
    
    let thirdSectionid: [(Any,CellFormat,Any)] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "HorizontalSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")    //Slider
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")   //def
        tableView.register(UINib(nibName: "GraphTableViewCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        tableView.alwaysBounceVertical = false
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.background
        
        firstSectionTitleView.titleLabel.text = "first section"
        firstSectionTitleView.titleId = 1
        
        for i in 0 ..< sectionNum{
            let s = SectionTitleViewX(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: sectionTitleHeight))
            s.titleLabel.text = " \(i) section "
            s.sectionId = i
            sectionTitleViews.append(s)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(catchNotif), name: Notification.Name(ConditionCheckModel.NotificationName.FirstSection.rawValue), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(ConditionCheckModel.NotificationName.FirstSection.rawValue), object: nil)
    }
    
    @objc private func catchNotif(notification: Notification){
        let sectionKey: String = notification.userInfo![ConditionCheckModel.UserInfoKey.SectionKey.rawValue] as! String
        let sectionValue: Float = notification.userInfo![ConditionCheckModel.UserInfoKey.Value.rawValue] as! Float
        logger.logger("\(sectionKey):\(sectionValue)")
        
        if ConditionCheckModel.FirstSection(rawValue: sectionKey) != nil{
            switch ConditionCheckModel.FirstSection(rawValue: sectionKey)!{
                
            case .Moning:
                SharedInputDataManager.shared.viewInputedData.morning = sectionValue
                break
            case .AM:
                SharedInputDataManager.shared.viewInputedData.am = sectionValue
                break
            case .Noon:
                SharedInputDataManager.shared.viewInputedData.noon = sectionValue
                break
            case .PM:
                SharedInputDataManager.shared.viewInputedData.pm = sectionValue
                break
            case .Evening:
                SharedInputDataManager.shared.viewInputedData.evening = sectionValue
                break
            case .Night:
                SharedInputDataManager.shared.viewInputedData.night = sectionValue
                break
            case .Nil:
                break
            }
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sectionNum
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return firstSectionId.count
        case 1:
            return secondSectionId.count
        case 2:
            return thirdSectionid.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "first section"
        case 1:
            return "second section"
        case 2:
            return "third section"
        default:
            return "??? section"
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 0:
            return sectionTitleViews[0]
        case 1:
            return sectionTitleViews[1]
        case 2:
            return sectionTitleViews[2]
        default:
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionTitleHeight
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            switch firstSectionId[indexPath.row].1{
                
            case .DEF:
                let cell = tableView.dequeueReusableCell(withIdentifier: secondSectionId[indexPath.row].1.rawValue, for: indexPath)
                firstSectionId[indexPath.row].2 = cell
                cell.selectionStyle = .none
                return cell
            case .SLIDER:
                let cell: HorizontalSliderTableViewCell = tableView.dequeueReusableCell(withIdentifier: firstSectionId[indexPath.row].1.rawValue, for: indexPath) as! HorizontalSliderTableViewCell
                firstSectionId[indexPath.row].2 = cell
                cell.setData(section: firstSectionId[indexPath.row].0)
                cell.selectionStyle = .none
                return cell
            case .GRAPH:
                let cell = tableView.dequeueReusableCell(withIdentifier: secondSectionId[indexPath.row].1.rawValue, for: indexPath)
                firstSectionId[indexPath.row].2 = cell
                cell.selectionStyle = .none
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: secondSectionId[indexPath.row].1.rawValue, for: indexPath)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: secondSectionId[indexPath.row].1.rawValue, for: indexPath)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: secondSectionId[indexPath.row].1.rawValue, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 100
        case 1:
            return 100
        case 2:
            return 100
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        logger.logger("row: \(indexPath.row)")
    }

}
