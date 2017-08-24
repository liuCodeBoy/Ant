//
//  HouseRentStatus.swift
//  Ant
//
//  Created by Weslie on 2017/8/11.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class HouseRentStatus: NSObject {

    var title: String?
    var empty_time: Int?
    var time: String?
    var house_type: String?
    var house_source: String?
    var price: Int?
    var contact_name: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
