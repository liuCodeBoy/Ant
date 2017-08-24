//
//  SecondHandIssueVC.swift
//  Ant
//
//  Created by Weslie on 2017/8/22.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class SecondHandIssueVC: GiveOutVC {

    override func viewDidLoad() {
        
        self.listTableView = HouseRentTabView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .grouped)
        
        super.viewDidLoad()
        
    }

}
