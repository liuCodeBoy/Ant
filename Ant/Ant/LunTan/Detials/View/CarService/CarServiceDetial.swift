//
//  CarServiceDetial.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class CarServiceDetial: UITableViewCell {
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var website: UIButton!
    
    @IBAction func website(_ sender: UIButton) {
        print("website clicked")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        website.addSingleUnderline(color: .blue)
    }
    
}
