//
//  SecondHandBasicInfo.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class SecondHandBasicInfo: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var kind: UILabel!
    @IBOutlet weak var belong: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.changeBorderLineStyle(target: kind, borderColor: .lightGray)
        self.changeBorderLineStyle(target: belong, borderColor: skyblue)
    }
    
}
