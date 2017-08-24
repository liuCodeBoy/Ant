//
//  LocationInfo.swift
//  DetialsOfAntDemo
//
//  Created by Weslie on 2017/7/17.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class LocationInfo: UITableViewCell {
    
    
    @IBOutlet weak var locationLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            if let location = viewModel?.area {
                self.locationLbl.text = location
            }
        }
    }
    
    
}
