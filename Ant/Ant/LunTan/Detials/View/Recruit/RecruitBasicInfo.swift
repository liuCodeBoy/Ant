//
//  RecruitBasicInfo.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class RecruitBasicInfo: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var fullOrPart: UILabel!
    @IBOutlet weak var needExperience: UILabel!
    @IBOutlet weak var price: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.changeBorderLineStyle(target: fullOrPart, borderColor: .lightGray)
        self.changeBorderLineStyle(target: needExperience, borderColor: skyblue)
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            if let title = viewModel?.title {
                self.title.text = title
            }
            if let fullorpart = viewModel?.job_nature {
                self.fullOrPart.text = fullorpart
            }
            if let exp = viewModel?.experience {
                self.needExperience.text = exp
            }
            if let price = viewModel?.expect_wage {
                self.price.text = price
            }
        }
    }
    
}
