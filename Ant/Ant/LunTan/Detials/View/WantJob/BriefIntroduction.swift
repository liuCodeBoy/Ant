//
//  SelfIntroduction.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class BriefIntroduction: UITableViewCell {

    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var nameAndSex: UILabel!
    @IBOutlet weak var fullOrPart: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var expectSalary: UILabel!
    @IBOutlet weak var workingNature: UILabel!
    @IBOutlet weak var academic: UILabel!
    @IBOutlet weak var industry: UILabel!
    @IBOutlet weak var visa: UILabel!
    @IBOutlet weak var experience: UILabel!
    
    @IBOutlet weak var createTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCustomStyles()
        
    
    }
    
    fileprivate func setCustomStyles() {
        
        self.avaImg.layer.cornerRadius = avaImg.frame.width / 2
        self.avaImg.layer.masksToBounds = true
        self.changeBorderLineStyle(target: fullOrPart, borderColor: .darkGray)
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            // MARK:- 设置用户头像
            
            if let location = viewModel?.area {
                self.location.text = location
            }
            if let indus = viewModel?.industry {
                self.industry.text = indus
            }
            if let expect = viewModel?.expect_wage {
                self.expectSalary.text = expect
            }
            if let visa = viewModel?.visa {
                self.visa.text = visa
            }
            if let nature = viewModel?.job_nature {
                self.workingNature.text = nature
                self.fullOrPart.text = nature
            }
            if let exp = viewModel?.experience {
                self.experience.text = exp
            }
            if let edu = viewModel?.education {
                self.academic.text = edu
            }
            if let time = viewModel?.want_job_creat {
                self.createTime.text = time
            }
        }
    }
    
}
