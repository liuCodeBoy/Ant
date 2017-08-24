//
//  NewsThreeImageCell.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/7/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class NewsThreeImageCell: UITableViewCell {
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsFirstImageView: UIImageView!
    @IBOutlet weak var newsSecondImageView: UIImageView!
    @IBOutlet weak var newsThridImageView: UIImageView!
    @IBOutlet weak var scourceText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
