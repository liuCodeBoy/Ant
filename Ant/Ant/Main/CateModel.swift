//
//  CateModel.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/11.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import MJExtension
class CateModel: NSObject {
    var ID: NSNumber?
    var name : String?
    var  desc : String?
    
    override init(){
        super.init()
        CateModel.mj_setupReplacedKey { () -> [AnyHashable : Any]? in
             return ["desc" : "description"]
        }
    }

}
