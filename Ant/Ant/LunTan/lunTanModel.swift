
//
//  lunTanModel.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/18.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class lunTanModel: NSObject {

    var name: String?
    var image: String?
    
    override init() {
        super.init()
    }
   
    class func getmodelHeight(btnCount: Int) -> CGFloat {
        let margin = CGFloat(10)
        let width = (screenWidth - CGFloat(5 * margin)) / 4
        let row = CGFloat((btnCount - 1) / 4) + 1
        return CGFloat(row * width + 60)
    }
    
}
