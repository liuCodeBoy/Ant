//
//  BasicInfo.swift
//  DetialsOfAntDemo
//
//  Created by Weslie on 2017/7/17.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class RentOutBasicInfo: UITableViewCell {
    
    
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var houseType: UILabel!
    @IBOutlet weak var rentType: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.changeBorderLineStyle(target: houseType, borderColor: .lightGray)
        self.changeBorderLineStyle(target: rentType, borderColor: .init(red: 102 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1))
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            name.text = viewModel?.title
            if let house_type = viewModel?.house_type {
                houseType.setTitleWithSpace(house_type)

            }
            if let house_source = viewModel?.house_source {
                rentType.setTitleWithSpace(house_source)
            }
            
            if let price = viewModel?.price {
                self.price.setPrice(price)
            }
            
            
        }
    }


    
}
