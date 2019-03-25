//
//  ConditionGraphTableViewController.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/12.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class ConditionGraphTableViewController: UITableViewController {
    
    let logger = Logger(true)
    
    fileprivate let refreshCtl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        logger.logger()
        tableView.register(UINib(nibName: "BeziaPathTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")    //Slider
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")   //def
        tableView.register(UINib(nibName: "GraphTableViewCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        tableView.refreshControl = refreshCtl
        refreshCtl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    
    @objc
    private func refresh(sender: UIRefreshControl){
        tableView.reloadData()
        refreshCtl.endRefreshing()
    }

    override func viewWillAppear(_ animated: Bool) {
        logger.logger()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        logger.logger()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "graph"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  indexPath.row {
        case 0:
            let cell: GraphTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! GraphTableViewCell
            cell.setData(section: "")
            return cell
        case 1:
            let cell: BeziaPathTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BeziaPathTableViewCell
            cell.setData(section: "")
            return cell
        default:
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }

}
