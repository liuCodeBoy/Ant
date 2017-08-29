 //
//  UserInfoModel.swift
//  Ant
//
//  Created by Weslie on 2017/7/14.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class UserInfoModel {
    
    static let shareInstance: UserInfoModel = UserInfoModel()
    
    var account: UserInfo?
    
    var accountPath: String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("userInfo.plist")
    }
    
    var isLogin: Bool {
        
        if account == nil {
            return false
        }
        
        guard (account?.phoneNumber) != nil else {
            return false
        }
        return true
        
    }
    
    init() {
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserInfo
    }
    
}
