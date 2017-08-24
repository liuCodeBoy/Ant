//
//  CommentListVC.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/28.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class CommentListVC: UITableViewController {
    let hotCommandCell = "hotCommandCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.tableView.separatorStyle = .none;
        self.tableView.register(UINib.init(nibName: "NewsHotCommondCell", bundle: nil), forCellReuseIdentifier: hotCommandCell)
    }

   
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  230
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: hotCommandCell)
        return cell!
    }

}
