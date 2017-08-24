//
//  HotNewsCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/27.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class HotNewsCell: UITableViewCell {
    @IBOutlet weak var hotNewsPic: UIImageView!
    @IBOutlet weak var hotNewsSource: UIButton!
    @IBOutlet weak var hotNewsTitle: UILabel!
    @IBOutlet weak var hotNewsTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
