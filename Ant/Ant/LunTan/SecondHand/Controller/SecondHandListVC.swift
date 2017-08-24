//
//  SecondHandListVC.swift
//  Ant
//
//  Created by Weslie on 2017/8/21.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class SecondHandListVC: UIViewController {
    
    @IBOutlet weak var issue: UIBarButtonItem!
    
    @IBOutlet weak var label: UILabel!
    
    var categoryName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = categoryName
        
        issue.target = self
        issue.action = #selector(pushIssueVC)
    }
    
    func pushIssueVC() {
        let giveVC = GiveOutVC()
        giveVC.listTableView = HouseRentTabView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .grouped)
        self.navigationController?.pushViewController(giveVC, animated: true)
        
    }

}
