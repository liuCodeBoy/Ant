//
//  RentInfo.swift
//  DetialsOfAntDemo
//
//  Created by Weslie on 2017/7/17.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class RentOutDetial: UITableViewCell {
    
    @IBOutlet weak var houseType: UILabel!
    @IBOutlet weak var rentWays: UILabel!
    @IBOutlet weak var checkInTime: UILabel!
    @IBOutlet weak var minRentTime: UILabel!
    
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var lable2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        changeBorderLineStyle(target: lable1, borderColor: .orange)
        changeBorderLineStyle(target: lable2, borderColor: skyblue)
      
    }
    
    var viewModel: LunTanDetialModel? {
        didSet{
            
            if let house_type = viewModel?.house_type {
                self.houseType.text = house_type
            }
            if let rent_way = viewModel?.rent_way {
                self.rentWays.text = rent_way
            }
            if let checkin = viewModel?.checkinTime {
                self.checkInTime.text = checkin
            }
            if let label = viewModel?.labelItems?[0] {
                lable1.setTitleWithSpace(label)
            }
//            if let label = viewModel?.labelItems?[1] {
//                lable2.setTitleWithSpace(label)
//            }
            
        }
      
    }
    
}
