//
//  ContactModel.swift
//  Ant
//
//  Created by Weslie on 2017/8/11.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class ContactModel: NSObject {
    
    var contact_name: String?
    
    var contact_phone: String?
    
    var wexin: String?
    
    var qq: String?
    
    var email: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
