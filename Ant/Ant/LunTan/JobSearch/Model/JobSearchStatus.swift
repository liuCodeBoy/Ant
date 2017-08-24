//
//  JobSearchStatus.swift
//  Ant
//
//  Created by Weslie on 2017/8/17.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class JobSearchStatus: NSObject {
    
    var title: String?
    var job_nature: String?
    var visa: String?
    var area: String?
    var contact_name: String?
    var time: String?
    
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
