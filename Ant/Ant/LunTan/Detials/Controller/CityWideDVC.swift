//
//  CityWideDetialVC.swift
//  Ant
//
//  Created by Weslie on 2017/8/3.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class CityWideDVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    
    var modelInfo: LunTanDetialModel?
    
    //定义标题高度
    var titHeight = 20
    //定义接受id
    var cityWideId  = 0
    lazy var urls = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetialTableView()
        loadCellData(index: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func loadDetialTableView() {
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60)
        
        self.tableView = UITableView(frame: frame, style: .grouped)
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        
        self.tableView?.separatorStyle = .singleLine
        
        tableView?.register(UINib(nibName: "CityWideBasicInfo", bundle: nil), forCellReuseIdentifier: "cityWideBasicInfo")
        tableView?.register(UINib(nibName: "CityWideDetial", bundle: nil), forCellReuseIdentifier: "cityWideDetial")
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
        case 0: return 2
        case 3: return 5
        case 5: return 10
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.6)
            var urlArray: [URL] = [URL]()
            for str in urls
            {
                let url = URL(string: str)
                urlArray.append(url!)
            }
            return LoopView(images: urlArray, frame: frame, isAutoScroll: true)
        
        case 1:
            let detialHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            detialHeader?.DetialHeaderLabel.text = "自我介绍"
            return detialHeader
        case 2:
            let askHeader = Bundle.main.loadNibNamed("DetialHeaderView", owner: nil, options: nil)?.first as? DetialHeaderView
            askHeader?.DetialHeaderLabel.text = "交友要求"
            return askHeader
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
            return 30
        case 2:
            return 30
        case 3:
            return 30
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
            let cityWideBasicInfo = tableView.dequeueReusableCell(withIdentifier: "cityWideBasicInfo") as! CityWideBasicInfo
            cityWideBasicInfo.viewModel = modelInfo
            self.titHeight = cityWideBasicInfo.cityWideHeight
            
            cell = cityWideBasicInfo
            if (cell?.responds(to: #selector(setter: UITableViewCell.separatorInset)))! {
                cell?.separatorInset = UIEdgeInsets.zero
                }
            case 1:
            let detialcontroduction = tableView.dequeueReusableCell(withIdentifier: "cityWideDetial") as! CityWideDetial
            detialcontroduction.viewModel = modelInfo
            cell = detialcontroduction
            if (cell?.responds(to: #selector(setter: UITableViewCell.separatorInset)))! {
                cell?.separatorInset = UIEdgeInsets.zero
                }
            default: break
            }
            
        case 1:
            let selfintro = tableView.dequeueReusableCell(withIdentifier: "detialControduction")
            selfintro?.textLabel?.text = modelInfo?.self_info
            
            cell = selfintro
            
        case 2:
            let friendreq = tableView.dequeueReusableCell(withIdentifier: "detialControduction")
            friendreq?.textLabel?.text = modelInfo?.friends_request
            
            cell = friendreq
            
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
            case 0: return CGFloat(self.titHeight + 40)
            case 1: return 150
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

extension CityWideDVC {
    
    // MARK:- load data
    
    fileprivate func loadCellData(index: Int) {
        let group = DispatchGroup()
        //将当前的下载操作添加到组中
        group.enter()
        NetWorkTool.shareInstance.infoDetial(VCType: .cityWide, id: cityWideId) { [weak self](result, error)  in
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
