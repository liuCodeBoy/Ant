//
//  NewsDetailSharedCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/27.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class NewsDetailSharedCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var interestBtn: UIButton!
    @IBOutlet weak var statement: UILabel!
    @IBAction func momentShare(_ sender: Any) {
    }
    
    @IBAction func weChatFriendAction(_ sender: Any) {
    }
    @IBAction func weiBoAction(_ sender: Any) {
    }
    @IBAction func moreSharedAction(_ sender: Any) {
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
