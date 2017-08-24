//
//  NewsTypeTableCell.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/7/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import SDWebImage
class NewsTypeTableCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    var  newlistModel : NewsListModel?
    override func awakeFromNib() {
        super.awakeFromNib()
     //   self.newsImage.sd_setImage(with: NSURL.init(string: newlistModel?.picture![0] as! String)! as URL)
      //  print(newlistModel?.title)
//        self.newsSource.text = newlistModel?.source
//        self.newsTitle.text = newlistModel?.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
