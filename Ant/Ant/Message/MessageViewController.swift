//
//  MessageViewController.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/7/3.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    
    let MeCellID = "MeCellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化tableview
       let tableView = UITableView.init(frame: CGRect.init(x: 0, y:0, width: screenWidth , height: screenHeight - 108), style: .grouped)
        tableView.backgroundColor = UIColor.init(white: 0.99, alpha: 0.5)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MeCellID)
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: MeCellID)
            
        }
        
        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = " 私信"
            cell?.imageView?.image = #imageLiteral(resourceName: "msg_icon_privateletter")
        case 1:
            cell?.textLabel?.text  = "评论回复"
            cell?.imageView?.image = #imageLiteral(resourceName: "msg_icon_commentback")
        default:
            cell?.textLabel?.text  = "帖子回复"
            cell?.imageView?.image = #imageLiteral(resourceName: "msg_icon_postreplies")
        }
        
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }

    
}
