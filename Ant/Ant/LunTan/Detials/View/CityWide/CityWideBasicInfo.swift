//
//  CityWideIntroduction.swift
//  Ant
//
//  Created by Weslie on 2017/8/3.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class CityWideBasicInfo: UITableViewCell {
    
    @IBOutlet weak var titleIntro: UILabel!
    
    @IBOutlet weak var academic: UILabel!
    @IBOutlet weak var hobby: UILabel!
    @IBOutlet weak var constellation: UILabel!

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var creatAt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        self.changeBorderLineStyle(target: academic, borderColor: .init(red: 102 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1))
        self.changeBorderLineStyle(target: hobby, borderColor: .red)
        self.changeBorderLineStyle(target: constellation, borderColor: .lightGray)
    
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            
            if let title = viewModel?.title {
                self.titleIntro.text = title
            }
            if let academic = viewModel?.education {
                self.academic.setTitleWithSpace(academic)
            }
            if let hobby = viewModel?.job {
                self.hobby.setTitleWithSpace(hobby)
            }
            if let constellation = viewModel?.constellation {
                self.constellation.setTitleWithSpace(constellation)
            }
            if let area = viewModel?.area {
                self.city.text = area
            }
            if let time = viewModel?.checkinTime {
                self.creatAt.text = time
            }
            
            
        }
    }

}
