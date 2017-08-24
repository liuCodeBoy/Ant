//
//  UserInfo.swift
//  Ant
//
//  Created by Weslie on 2017/7/14.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class UserInfo: NSObject, NSCoding {
    
    var phoneNumber: String?
    var password: String?
    var themColor: UIColor?
    var token : String?
    
    init(phoneNumber: String, password: String ,token : String) {
        self.phoneNumber = phoneNumber
        self.password = password
        self.token = token
    }
    
    init(phoneNumber: String , token : String) {
        self.phoneNumber = phoneNumber
        self.token = token
    }
 
    func encode(with aCoder: NSCoder) {
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(token, forKey: "token")
    }
    
    required init?(coder aDecoder: NSCoder) {
        phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
    }
}
