//
//  LunTanDetialModel.swift
//  Ant
//
//  Created by Weslie on 2017/8/15.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import SDWebImage

class LunTanDetialModel: NSObject {
    
    var id : NSNumber?
    var picture: [String]?
    var title: String?
    var house_type: String?
    var house_source: String?
    var price: String?
    var rent_way: String?
    var empty_time: Int?
    var area: String?
    var label: String?
    var content: String?
    var contact_name: String?
    var contact_phone: String?
    var weixin: String?
    var qq: String?
    var email: String?
    //MARK: -  求租
    var type:  String?

    
    // MARK:- 求职
    var education: String?
    var expect_wage: String?
    var experience: String?
    var industry_id: Int?
    var job_nature: String?
    var self_info: String?  //同城交友
    var time: Int?          //同城交友
    var visa: String?
    
    //汽车买卖
    var company_address: String?
    var company_internet: String?
    var company_name: String?
    
    //同城交友
    var age: String?
    var constellation: String?
    var felling_state: String?
    var friends_request: String?
    var height: String?
    var hometown: String?
    var job: String?
    var name: String?
    var sex: String?
    var weight: String?
    
    

    // MARK:- 处理完的数据
    var labelItems: [String]?
    lazy var pictureArray: [URL] = [URL]()
    var checkinTime: String?
    lazy var connactDict: [[String : String]] = [[String : String]]()
    
    var industry: String?
    var want_job_creat: String?
    
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeys(dict)
        
        //处理模型的数据
//        if let pictureArray = picture {
//            for urlItem in pictureArray {
//                let url = URL(string: urlItem)
//                self.pictureArray.append(url!)
//            }
//        }
        if let check = empty_time {
            checkinTime = Date.createDateString(String(check))
        }
        if let labels = label {
            labelItems = labels.components(separatedBy: ",")
        }
        
        //联系人信息
        if let name = self.contact_name {
            connactDict.append(["联系人" : name])
        }
        if let phone = self.contact_phone {
            connactDict.append(["电话" : phone])
        }
        if let weixin = self.weixin {
            connactDict.append(["微信" : weixin])
        }
        if let qq = self.qq {
            connactDict.append(["QQ" : qq])
        }
        if let email = self.email {
            connactDict.append(["邮箱" : email])
        }
        
        //求职信息
        if let industry = self.industry_id {
            switch industry {
            case 3:
                self.industry = "web攻城狮"
            default:
                self.industry = "sb"
            }
        }
        if let creat = self.time {
            want_job_creat = Date.createDateString(String(creat))
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}


