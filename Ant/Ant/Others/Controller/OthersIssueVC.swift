//
//  OthersIssueVC.swift
//  Ant
//
//  Created by Weslie on 2017/8/23.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class OthersIssueVC: UIViewController {
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var issueTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        issueTableView.delegate = self
        issueTableView.dataSource = self

    }
}


   func loadSelfData() -> () {
    
}

extension OthersIssueVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "issueCell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
}
