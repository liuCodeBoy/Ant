//
//  RentNeedDetial.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class RentNeedDetial: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var rentNeedWay: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var expectFacilities: UILabel!
    @IBOutlet weak var tradeNature: UILabel!
    @IBOutlet weak var expectType: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            if let title = viewModel?.title {
                self.title.text = title
            }
            if let area = viewModel?.area {
                self.location.text = area
            }
            
            // MARK:- 期望设施
            
            
            if let source = viewModel?.house_source {
                self.tradeNature.text = source
            }
            if let type = viewModel?.house_type {
                self.expectType.text = type
            }
            
            // MARK:- 关键标签

            
        }
    }
}
