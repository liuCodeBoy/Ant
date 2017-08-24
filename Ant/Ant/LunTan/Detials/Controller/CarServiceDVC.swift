//
//  CarServiceDVC.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class CarServiceDVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetialTableView()
        
        let view = Menu()
        self.tabBarController?.tabBar.isHidden = true
        view.frame = CGRect(x: 0, y: screenHeight - 134, width: screenWidth, height: 70)
        self.view.addSubview(view)
    }
    
    
    func loadDetialTableView() {
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 70)
        
        self.tableView = UITableView(frame: frame, style: .grouped)
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        
        self.tableView?.separatorStyle = .singleLine
        
        tableView?.register(UINib(nibName: "CarServiceBasicInfo", bundle: nil), forCellReuseIdentifier: "carServiceBasicInfo")
        tableView?.register(UINib(nibName: "CarServiceDetial", bundle: nil), forCellReuseIdentifier: "carServiceDetial")
        tableView?.register(UINib(nibName: "LocationInfo", bundle: nil), forCellReuseIdentifier: "locationInfo")
        tableView?.register(UINib(nibName: "DetialControduction", bundle: nil), forCellReuseIdentifier: "detialControduction")
        tableView?.register(UINib(nibName: "ConnactOptions", bundle: nil), forCellReuseIdentifier: "connactOptions")
        tableView?.register(UINib(nibName: "MessageHeader", bundle: nil), forCellReuseIdentifier: "messageHeader")
        tableView?.register(UINib(nibName: "MessagesCell", bundle: nil), forCellReuseIdentifier: "messagesCell")
        
        tableView?.separatorStyle = .singleLine
        
        self.view.addSubview(tableView!)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3
        case 2: return 5
        case 4: return 10
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.6)
            
            let urls = [
                "http://img3.cache.netease.com/photo/0009/2016-05-27/BO1HVHOV0AI20009.jpg",
                "http://img3.cache.netease.com/photo/0009/2016-05-27/BO1HVIJ30AI20009.png",
                "http://img5.cache.netease.com/photo/0009/2016-05-27/BO1HVLIM0AI20009.jpg",
                "http://img6.cache.netease.com/photo/0009/2016-05-27/BO1HVJCD0AI20009.jpg",
                "http://img2.cache.netease.com/photo/0009/2016-05-27/BO1HVPUT0AI20009.png"
            ]
            
            var urlArray: [URL] = [URL]()
            for str in urls {
                let url = URL(string: str)
                urlArray.append(url!)
            }
            
            return LoopView(images: urlArray, frame: frame, isAutoScroll: true)
        case 1:
            let detialHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            detialHeader?.DetialHeaderLabel.text = "详情介绍"
            return detialHeader
        case 2:
            let connactHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            connactHeader?.DetialHeaderLabel.text = "联系人方式"
            return connactHeader
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            return Bundle.main.loadNibNamed("Share", owner: nil, options: nil)?.first as? UIView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return UIScreen.main.bounds.width * 0.6
        case 1:
            return 38
        case 2:
            return 38
        case 3:
            return 10
        case 4:
            return 0.00001
        default:
            return 0.00001
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 140
        } else {
            return 0.00001
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        switch indexPath.section {
        case 0:
            
            switch indexPath.row {
            case 0: cell = tableView.dequeueReusableCell(withIdentifier: "carServiceBasicInfo")
            
            if (cell?.responds(to: #selector(setter: UITableViewCell.separatorInset)))! {
                cell?.separatorInset = UIEdgeInsets.zero
                }
                
                
            case 1: cell = tableView.dequeueReusableCell(withIdentifier: "carServiceDetial")
            if (cell?.responds(to: #selector(setter: UITableViewCell.separatorInset)))! {
                cell?.separatorInset = UIEdgeInsets.zero
                }
            case 2: cell = tableView.dequeueReusableCell(withIdentifier: "locationInfo")
            default: break
            }
            
        case 1: cell = tableView.dequeueReusableCell(withIdentifier: "detialControduction")
            
        case 2: cell = tableView.dequeueReusableCell(withIdentifier: "connactOptions")
        if (cell?.responds(to: #selector(setter: UITableViewCell.separatorInset)))! {
            cell?.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
            }
        case 3: cell = tableView.dequeueReusableCell(withIdentifier: "messageHeader")
            
        case 4: cell = tableView.dequeueReusableCell(withIdentifier: "messagesCell")
            
        default: break
        }

        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: return 60
            case 1: return 100
            case 2: return 40
            default: return 20
            }
        case 1:
            return detialHeight + 10
        case 2:
            return 50
        case 3:
            return 40
        case 4:
            return 120
        default:
            return 20
        }
    }
    
    
}

