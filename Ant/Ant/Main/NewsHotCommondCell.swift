//
//  NewsHotCommondCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/27.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class NewsHotCommondCell: UITableViewCell {
    @IBOutlet weak var userPicImage: UIImageView! 
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var zanLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
