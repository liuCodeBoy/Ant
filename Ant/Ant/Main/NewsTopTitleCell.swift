//
//  NewsTopTitleCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/15.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class NewsTopTitleCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var source: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
