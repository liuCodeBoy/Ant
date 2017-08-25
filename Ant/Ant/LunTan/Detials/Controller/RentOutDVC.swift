//
//  DatailViewController.swift
//  Ant
//
//  Created by Weslie on 2017/7/19.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class RentOutDVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    
    var modelInfo: LunTanDetialModel?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetialTableView()
        
        // MARK:- 底部菜单
        let menuView = Menu()
        self.tabBarController?.tabBar.isHidden = true
        menuView.frame = CGRect(x: 0, y: screenHeight - 124, width: screenWidth, height: 60)
        self.view.addSubview(menuView)
        loadCellData(index: 1)

    }
    
    
    func loadDetialTableView() {
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60)
        
        self.tableView = UITableView(frame: frame, style: .grouped)
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        
        self.tableView?.separatorStyle = .singleLine
        
        tableView?.register(UINib(nibName: "RentOutBasicInfo", bundle: nil), forCellReuseIdentifier: "rentOutBasicInfo")
        tableView?.register(UINib(nibName: "RentOutDetial", bundle: nil), forCellReuseIdentifier: "rentOutDetial")
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
        case 3: return 1
        case 4: return 1
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
            
//            if let pic = modelInfo?.pictureArray {
//                return LoopView(images: pic, frame: frame, isAutoScroll: true)
//            } else {
//                return LoopView(images: urlArray, frame: frame, isAutoScroll: true)
//            }
            
            return LoopView(images: urlArray, frame: frame, isAutoScroll: true)

            
            
        case 1:
            
            let detialHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            detialHeader?.DetialHeaderLabel.text = "详情介绍"
            
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
            return UIScreen.main.bounds.width * 0.6
        case 1:
            return 30
        case 2:
            return 30
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
            case 0:
                let rentoutbasicinfo = tableView.dequeueReusableCell(withIdentifier: "rentOutBasicInfo") as! RentOutBasicInfo
                rentoutbasicinfo.viewModel = modelInfo
            
                cell = rentoutbasicinfo
            
            if (cell?.responds(to: #selector(setter: UITableViewCell.separatorInset)))! {
                cell?.separatorInset = UIEdgeInsets.zero
                }
                
            case 1:
                let rentoutdetial = tableView.dequeueReusableCell(withIdentifier: "rentOutDetial") as! RentOutDetial
                rentoutdetial.viewModel = modelInfo
                
                cell = rentoutdetial
                
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
            switch indexPath.row {
            case 0: return 60
            case 1: return 110
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 2:
            switch indexPath.row {
            case 1:
                //自动打开拨号页面并自动拨打电话
                let urlString = "tel://123456"
                if let url = URL(string: urlString) {
                    //根据iOS系统版本，分别处理
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:],
                                                  completionHandler: {
                                                    (success) in
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            default:
                break
            }
        default:
            break
        }
    }

}

extension RentOutDVC {
    
    // MARK:- load data
    
    fileprivate func loadCellData(index: Int) {
        let group = DispatchGroup()
        //将当前的下载操作添加到组中
        group.enter()
        NetWorkTool.shareInstance.infoDetial(VCType: .house, id: index + 1) { [weak self](result, error)  in
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
