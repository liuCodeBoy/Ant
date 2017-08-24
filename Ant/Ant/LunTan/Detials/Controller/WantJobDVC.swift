//
//  WantJobDVC.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

import UIKit

class WantJobDVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    
    var modelInfo: LunTanDetialModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCellData(index: 2)
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
        
        tableView?.register(UINib(nibName: "BriefIntroduction", bundle: nil), forCellReuseIdentifier: "briefIntroduction")
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
        if section == 2 {
            return 5
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            
            let brief = Bundle.main.loadNibNamed("BriefIntroduction", owner: nil, options: nil)?.first as? BriefIntroduction
            brief?.viewModel = modelInfo
            return brief
        case 1:
            let detialHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            detialHeader?.DetialHeaderLabel.text = "详细介绍"
            return detialHeader
        case 2:
            let connactHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            connactHeader?.DetialHeaderLabel.text = "联系方式"
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
            return 350
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
            let locationinfo = tableView.dequeueReusableCell(withIdentifier: "locationInfo") as! LocationInfo
            locationinfo.viewModel = modelInfo
            cell = locationinfo
            
        case 1:
            let detialcontroduction = tableView.dequeueReusableCell(withIdentifier: "detialControduction") as! DetialControduction
            detialcontroduction.viewModel = modelInfo
            detialcontroduction.detialLbl.text = modelInfo?.self_info
            cell = detialcontroduction
            
        case 2:
            
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
            
        case 3: cell = tableView.dequeueReusableCell(withIdentifier: "messageHeader")
            
        case 4: cell = tableView.dequeueReusableCell(withIdentifier: "messagesCell")
            
        default: break
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 40
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

extension WantJobDVC {
    
    // MARK:- load data
    
    fileprivate func loadCellData(index: Int) {
        let group = DispatchGroup()
        //将当前的下载操作添加到组中
        group.enter()
        NetWorkTool.shareInstance.infoDetial(VCType: .job, id: index + 1) { [weak self](result, error)  in
            //在这里异步加载任务
            
            if error != nil {
                print(error ?? "load house info list failed")
                return
            }
            
            guard let resultDict = result!["result"] else {
                return
            }
            
            let basic = LunTanDetialModel(dict: resultDict as! [String : AnyObject])
            self?.modelInfo = basic
            //离开当前组
            group.leave()
                        
        }
        group.notify(queue: DispatchQueue.main) {
            //在这里告诉调用者,下完完毕,执行下一步操作
            self.tableView?.reloadData()
            
        }
    }
    
}

