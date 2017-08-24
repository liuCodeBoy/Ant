//
//  CarServieBasicInfo.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class CarServiceBasicInfo: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var service: UILabel!
    @IBOutlet weak var location: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        self.changeBorderLineStyle(target: service, borderColor: .lightGray)
        self.changeBorderLineStyle(target: location, borderColor: skyblue)
        
    }
    
}
