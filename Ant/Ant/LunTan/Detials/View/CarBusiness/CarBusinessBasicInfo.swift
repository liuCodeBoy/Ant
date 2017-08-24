//
//  SecondHandBasicInfo.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class CarBusinessBasicInfo: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.changeBorderLineStyle(target: year, borderColor: .lightGray)
        self.changeBorderLineStyle(target: brand, borderColor: skyblue)
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            
        }
    }
    
}
