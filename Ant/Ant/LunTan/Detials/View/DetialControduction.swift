//
//  DetialControduction.swift
//  DetialsOfAntDemo
//
//  Created by Weslie on 2017/7/17.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

var detialHeight: CGFloat = 20.0

class DetialControduction: UITableViewCell {
    
    
    @IBOutlet weak var detialLbl: UILabel!
    @IBOutlet weak var DetialHCons: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
  
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            if let text = viewModel?.content {
                self.detialLbl.text = text
                DetialHCons.constant = detialLbl.getLabHeight(labelStr: detialLbl.text!, font: detialLbl.font, width: UIScreen.main.bounds.width - 40)
                detialHeight = DetialHCons.constant
        
            }
        }
    }
}



