//
//  CityWideDetial.swift
//  Ant
//
//  Created by Weslie on 2017/8/3.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class CityWideDetial: UITableViewCell {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var academic: UILabel!
    @IBOutlet weak var hometown: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            if let area = viewModel?.area {
                self.city.text = area
            }
            if let sex = viewModel?.sex {
                self.sex.text = sex
            }
            if let age = viewModel?.age {
                self.age.text = age
            }
            if let height = viewModel?.height {
                self.height.text = height
            }
            if let weight = viewModel?.weight {
                self.height.text = weight
            }
            if let academic = viewModel?.education {
                self.academic.text = academic
            }
            if let job = viewModel?.job {
                self.academic.text = job
            }
            if let home = viewModel?.hometown {
                self.hometown.text = home
            }
        }
    }
    
}
