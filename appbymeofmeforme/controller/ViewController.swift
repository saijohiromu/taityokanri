//
//  ViewController.swift
//  appbymeofmeforme
//
//  Created by itolab on 2019/02/09.
//  Copyright © 2019年 hiromusaijo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: "toTabBar", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toTabBar":
            
            break
        default:
            break
        }
    }


}

