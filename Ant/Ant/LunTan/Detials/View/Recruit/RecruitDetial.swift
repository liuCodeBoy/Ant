//
//  RecruitDetial.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class RecruitDetial: UITableViewCell {
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var jobNature: UILabel!
    @IBOutlet weak var academicRequired: UILabel!
    @IBOutlet weak var industry: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var visa: UILabel!
    @IBOutlet weak var experienceRequired: UILabel!
    @IBOutlet weak var creatTime: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    var viewModel:LunTanDetialModel? {
        didSet {
            if let location = viewModel?.area {
                self.location.text = location
            }
            if let indus = viewModel?.industry {
                self.industry.text = indus
            }
            // MARK:- 公司名称 人数
            
            if let fullpart = viewModel?.job_nature {
                self.jobNature.text = fullpart
            }
            if let visa = viewModel?.visa {
                self.visa.text = visa
            }
            if let edu = viewModel?.education {
                self.academicRequired.text = edu
            }
            if let exp = viewModel?.experience {
                self.experienceRequired.text = exp
            }
            if let time = viewModel?.want_job_creat {
                self.creatTime.text = time
            }
        }
    }
    
}
