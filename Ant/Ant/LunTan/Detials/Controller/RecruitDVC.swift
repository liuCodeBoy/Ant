//
//  RecruitDVC.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class RecruitDVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    
    var modelInfo: LunTanDetialModel?
    
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
        
        tableView?.register(UINib(nibName: "RecruitBasicInfo", bundle: nil), forCellReuseIdentifier: "recruitBasicInfo")
        tableView?.register(UINib(nibName: "RecruitDetial", bundle: nil), forCellReuseIdentifier: "recruitDetial")
        tableView?.register(UINib(nibName: "LocationInfo", bundle: nil), forCellReuseIdentifier: "locationInfo")
        tableView?.register(UINib(nibName: "DetialControduction", bundle: nil), forCellReuseIdentifier: "detialControduction")
        tableView?.register(UINib(nibName: "ConnactOptions", bundle: nil), forCellReuseIdentifier: "connactOptions")
        tableView?.register(UINib(nibName: "MessageHeader", bundle: nil), forCellReuseIdentifier: "messageHeader")
        tableView?.register(UINib(nibName: "MessagesCell", bundle: nil), forCellReuseIdentifier: "messagesCell")
        
        tableView?.separatorStyle = .singleLine
        
        self.view.addSubview(tableView!)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 3
        case 3: return 5
        case 4: return 1
        case 5: return 1
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
            
            return LoopView(images: urlArray, frame: frame, isAutoScroll: true)        case 1:
            
            let detialHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            detialHeader?.DetialHeaderLabel.text = "详情介绍"
            
            return detialHeader
        case 2:
            
            let introHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            introHeader?.DetialHeaderLabel.text = "公司简介"
            
            return introHeader
        case 3:
            
            let connactHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            connactHeader?.DetialHeaderLabel.text = "联系人方式"
            return connactHeader
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
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
            return 38
        case 4:
            return 10
        case 5:
            return 0.00001
        default:
            return 0.00001
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
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
            case 0:
                let basic = tableView.dequeueReusableCell(withIdentifier: "recruitBasicInfo") as! RecruitBasicInfo
                basic.viewModel = modelInfo
                cell = basic
            
            if (cell?.responds(to: #selector(setter: UITableViewCell.separatorInset)))! {
                cell?.separatorInset = UIEdgeInsets.zero
                }
                
                
            case 1:
                let detial = tableView.dequeueReusableCell(withIdentifier: "recruitDetial") as! RecruitDetial
                detial.viewModel = modelInfo
                cell = detial
                
            if (cell?.responds(to: #selector(setter: UITableViewCell.separatorInset)))! {
                cell?.separatorInset = UIEdgeInsets.zero
                }
            case 2:
                let locationinfo = tableView.dequeueReusableCell(withIdentifier: "locationInfo") as! LocationInfo
                locationinfo.viewModel = modelInfo
                cell = locationinfo
                
            default: break
            }
            
        case 1:
            let detialcontroduction = tableView.dequeueReusableCell(withIdentifier: "detialControduction") as! DetialControduction
            detialcontroduction.viewModel = modelInfo
            detialcontroduction.detialLbl.text = modelInfo?.title
            cell = detialcontroduction

            
        case 2:
            let detialcontroduction = tableView.dequeueReusableCell(withIdentifier: "detialControduction") as! DetialControduction
            detialcontroduction.viewModel = modelInfo
            detialcontroduction.detialLbl.text = modelInfo?.self_info
            cell = detialcontroduction
            
        case 3:
            
            let connactoptions = tableView.dequeueReusableCell(withIdentifier: "connactOptions") as! ConnactOptions
            
            if let key = modelInfo?.connactDict[indexPath.row].first?.key {
                connactoptions.con_Ways.text = key
            }
            if let value = modelInfo?.connactDict[indexPath.row].first?.value {
                connactoptions.con_Detial.text = value
            }
            
            
            switch modelInfo?.connactDict[indexPath.row].first?.key {
            case "联系人"?:
                connactoptions.con_Image.image = #imageLiteral(resourceName: "luntan_detial_icon_connact_profile")
            case "电话"?:
                connactoptions.con_Image.image = #imageLiteral(resourceName: "luntan_detial_icon_connact_phone")
            case "微信"?:
                connactoptions.con_Image.image = #imageLiteral(resourceName: "luntan_detial_icon_connact_wechat")
            case "QQ"?:
                connactoptions.con_Image.image = #imageLiteral(resourceName: "luntan_detial_icon_connact_qq")
            case "邮箱"?:
                connactoptions.con_Image.image = #imageLiteral(resourceName: "luntan_detial_icon_connact_email")
            default:
                break
            }
            
            cell = connactoptions

        if (cell?.responds(to: #selector(setter: UITableViewCell.separatorInset)))! {
            cell?.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
            }
        case 4: cell = tableView.dequeueReusableCell(withIdentifier: "messageHeader")
            
        case 5: cell = tableView.dequeueReusableCell(withIdentifier: "messagesCell")
            
        default: break
        }
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: return 60
            case 1: return 150
            case 2: return 40
            default: return 20
            }
        case 1:
            return detialHeight + 10
        case 2:
            return detialHeight + 10
        case 3:
            return 50
        case 4:
            return 40
        case 5:
            return 120
        default:
            return 20
        }
    }


}
