//
//  HouseRentTabView.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/18.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
typealias pushModifyVC = (String? , IndexPath) -> (Void)
typealias pushChooseVC = ([String] , IndexPath) -> (Void)
class HouseRentTabView: UITableView,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    var  tableView = UITableView()
    var  textField  : UITextField?
    //初始化一个闭包类型
    var  pushModifyVCClouse : pushModifyVC?
    var  pushChooseVCClouse : pushChooseVC?
    fileprivate let cellID = "cellID"
    //初始化一个房屋出租模型
    var houseRentstaus  = HouseRentStatus()
    //创建房屋出租字典
    var houseRentDic  = NSMutableDictionary()
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        tableView = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var  row  :  Int = 0
        switch  section  {
        case 0:
            row = 1
        case 1:
            row = 7
        case 2:
            row = 6
        default:
            row = 0
        }
        return row
    }
  
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        let titleLabel = UILabel()
        titleLabel.text  = "联系人方式"
        titleLabel.textColor = UIColor.lightGray
        titleLabel.sizeToFit()
        titleLabel.center.y = 20
        titleLabel.frame.origin.x = 20
        headerView.addSubview(titleLabel)
        
        switch section {
        case 0:
            titleLabel.text = "消息标题"
        case 1:
            titleLabel.text  = "基本信息"
        case 2:
            titleLabel.text  = "联系人方式"
        default:
            titleLabel.text = ""
            
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        var view = UIView.init()
        
        switch section {
        case 1:
      
        let detailView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 180))
         detailView.backgroundColor = UIColor.white
         let detailScriptLable  = UILabel.init(frame: CGRect.init(x: 15, y: 10, width: 100, height: 20))
         detailScriptLable.text = "详尽描述"
         detailView.addSubview(detailScriptLable)
         let detailDescriptFiled = CustomTextField.init(frame: CGRect.init(x: 10, y: 30, width: screenWidth - 20 , height: 140), placeholder: "字数在150字以内", clear: true, leftView: nil, fontSize: 12)
         detailDescriptFiled?.backgroundColor = UIColor.init(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0)
            self.textField = detailDescriptFiled
            detailView.addSubview(detailDescriptFiled!)
            view = detailView
        default:
            break
        }
        return view
 
    }
    
    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        self.endEditing(true)
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var  heightForFooterInSection = 0.0
        switch section {
        case 1:
            heightForFooterInSection = 180
//        case 2:
//            heightForFooterInSection = 100
        default:
            heightForFooterInSection = 0.0
        }
        return CGFloat(heightForFooterInSection)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //点击事件触发
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let  cell = tableView.cellForRow(at: indexPath)
       let  detailText =   cell?.detailTextLabel?.text == nil ?  " " : cell?.detailTextLabel?.text
        if indexPath.section == 1 {
        if indexPath.row == 1 {
            cell?.textLabel?.text  = "房屋户型"
            if self.pushChooseVCClouse != nil {
                let  wayArr = ["不限","Apartment","House","Unit","Studio","Town House","Office","仓库/车库","其它"]
                self.pushChooseVCClouse!(wayArr ,indexPath)
            }
            }else if indexPath.row == 2 {
            cell?.textLabel?.text = "出租方式"
            if self.pushChooseVCClouse != nil {
                let  wayArr = ["不限","单间","客厅","整租","share"]
                self.pushChooseVCClouse!(wayArr ,indexPath)
             }
            }else{
               if self.pushModifyVCClouse != nil {
                pushModifyVCClouse!(detailText!, indexPath)
            }
        }
        }else{
            if self.pushModifyVCClouse != nil {
                pushModifyVCClouse!(detailText!, indexPath)
                 }
            }
    }
    
    
    //改变tableview数据状态
    func  changeTableData(indexPath: IndexPath , text : String?){
        if indexPath.section == 0 {
            houseRentstaus.title = text
        }else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                houseRentstaus.area = text
            case 1:
                houseRentstaus.house_type = text
            case 2:
                houseRentstaus.rent_way = text
            case 3:
                houseRentstaus.empty_time = Int(text!)
            case 4:
                 houseRentstaus.house_source = text
            case 5:
                 houseRentstaus.price = text
            default:
                 break
            }
        }else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                houseRentstaus.contact_name = text
            case 1:
                houseRentstaus.contact_phone = text
            case 2:
                houseRentstaus.weixin = text
            case 3:
                houseRentstaus.qq = text
            case 4:
                houseRentstaus.email = text
            case 5:
                houseRentstaus.label = text
            default:
                break
            }
        }
        self.houseRentDic = ["title" : houseRentstaus.title,
                             "area" : houseRentstaus.area ,
                             "content" : self.textField?.text ,
                             "house_type" : houseRentstaus.house_type ,
                             "rent_way" : houseRentstaus.rent_way ,
                             "empty_time" : "\(houseRentstaus.empty_time)" ,
                             "time" : houseRentstaus.time,
                             "house_source": houseRentstaus.house_source ,
                             "price" : houseRentstaus.price ?? String(),
                             "contact_name" : houseRentstaus.contact_name ,
                             "contact_phone" : houseRentstaus.contact_phone ,
                             "weixin" : houseRentstaus.weixin ,
                             "qq" : houseRentstaus.qq ,
                             "email" : houseRentstaus.email ,
                             "label" : houseRentstaus.label 
                             ]
        
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if  cell == nil {
            cell = UITableViewCell.init(style: .value1 , reuseIdentifier: cellID)
        }
         cell?.detailTextLabel?.text = " "
        cell?.accessoryType = .disclosureIndicator
        if indexPath.section == 0 {
            cell?.textLabel?.text = "标题"
            cell?.detailTextLabel?.text = houseRentstaus.title
        }else if indexPath.section == 1 {
            
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "所在区域"
                cell?.detailTextLabel?.text = houseRentstaus.area
            case 1:
                cell?.textLabel?.text  = "房屋户型"
                cell?.detailTextLabel?.text = houseRentstaus.house_type
            case 2:
                cell?.textLabel?.text = "出租方式"
                cell?.detailTextLabel?.text = houseRentstaus.rent_way
            case 3:
                cell?.textLabel?.text = "空出时间"
               let emptyTime =  houseRentstaus.empty_time == nil ? "" : "\(houseRentstaus.empty_time!)"
               cell?.detailTextLabel?.text = emptyTime
            case 4:
                cell?.textLabel?.text = "房屋来源"
                cell?.detailTextLabel?.text = houseRentstaus.house_source
            case 5:
                cell?.textLabel?.text = "出租价格"
                cell?.detailTextLabel?.text = houseRentstaus.price
            case 6:
                cell?.textLabel?.text = "最短租期"
              
            default:
                cell?.textLabel?.text = ""
            }
        }else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "联系人名称"
                cell?.detailTextLabel?.text = houseRentstaus.contact_name
            case 1:
                cell?.textLabel?.text  = "联系电话"
                cell?.detailTextLabel?.text = houseRentstaus.contact_phone
            case 2:
                cell?.textLabel?.text = "微信"
                cell?.detailTextLabel?.text = houseRentstaus.weixin
            case 3:
                cell?.textLabel?.text = "QQ"
                cell?.detailTextLabel?.text = houseRentstaus.qq
            case 4:
                cell?.textLabel?.text = "邮箱"
                cell?.detailTextLabel?.text = houseRentstaus.email
            case 5:
                cell?.textLabel?.text = "选择标签"
                cell?.detailTextLabel?.text = houseRentstaus.label
            default:
                cell?.textLabel?.text = ""
            }
            
        }
        return cell!
    }
    
}

